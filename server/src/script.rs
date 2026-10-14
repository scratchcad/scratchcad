//! Sandboxed Rhai execution.
//!
//! Scripts use [scratchcad-occt-rhai](https://github.com/scratchcad/scratchcad-occt-rs)'s
//! bindings to OpenCASCADE and produce a shape either by calling `draw(shape)`
//! exactly once or by evaluating to a shape as their final expression.  The
//! result is a B-rep [`Shape`]; nothing is retained between requests.
//!
//! Shapes and the engine are neither `Send` nor `Sync`, so the engine is built
//! per call, inside the job that uses the shape.

use std::{cell::RefCell, rc::Rc, time::Instant};

use scratchcad_occt_rhai::{
    CancelToken, ErrorKind, Selection, Shape, Sketch, error_kind,
    rhai::{self, Dynamic, EvalAltResult},
    to_shape,
};

use crate::error::ApiError;

/// Maximum captured `print` / `debug` lines per script
const MAX_OUTPUT_LINES: usize = 100;
/// Maximum length of a single captured output line
const MAX_OUTPUT_LINE_LEN: usize = 1024;

#[derive(Debug, Clone, Copy)]
pub struct ScriptLimits {
    pub max_operations: u64,
    pub max_string_size: usize,
}

/// A script that has been executed
pub struct Compiled {
    pub shape: Shape,
    /// Captured `print` / `debug` output
    pub output: Vec<String>,
    /// Time spent executing the script, in milliseconds
    pub script_ms: f64,
}

type Output = Rc<RefCell<Vec<String>>>;

/// Builds a Rhai engine with the OpenCASCADE bindings and sandbox limits applied
fn engine(limits: &ScriptLimits, cancel: CancelToken, output: Output) -> rhai::Engine {
    // Registers every modelling function, with no filesystem access: `import`
    // resolves nothing, and error tags are read-only.
    let mut engine = scratchcad_occt_rhai::engine();

    // Resource limits.  The operation cap counts Rhai operations, not the
    // work an OpenCASCADE call does, so long calls are stopped by the job's
    // cancel token instead (see `jobs`).  The token is also checked between
    // operations, so timeouts interrupt long-running script loops.
    engine.set_max_operations(limits.max_operations);
    engine.on_progress(move |_| {
        cancel
            .is_cancelled()
            .then(|| Dynamic::from("script cancelled"))
    });
    engine.set_max_call_levels(64);
    engine.set_max_expr_depths(64, 32);
    engine.set_max_string_size(limits.max_string_size);
    engine.set_max_array_size(100_000);
    engine.set_max_map_size(10_000);
    engine.set_max_variables(10_000);
    engine.set_max_functions(1_000);

    // No modules at all, and no dynamic `eval`.
    engine.set_max_modules(0);
    engine.disable_symbol("eval");

    // Capture output instead of writing to the server's stdout.
    let out = output.clone();
    engine.on_print(move |s| push_line(&out, s.to_owned()));
    engine.on_debug(move |s, _src, pos| {
        push_line(&output, format!("[{pos}] {s}"));
    });
    engine
}

fn push_line(out: &RefCell<Vec<String>>, mut s: String) {
    let mut out = out.borrow_mut();
    if out.len() < MAX_OUTPUT_LINES {
        if s.len() > MAX_OUTPUT_LINE_LEN {
            let mut end = MAX_OUTPUT_LINE_LEN;
            while !s.is_char_boundary(end) {
                end -= 1;
            }
            s.truncate(end);
            s.push('…');
        }
        out.push(s);
    }
}

/// Whether `to_shape` can turn the value into a shape
fn is_shaped(value: &Dynamic) -> bool {
    value.is::<Shape>() || value.is::<Selection>() || value.is::<Sketch>() || value.is_array()
}

/// Executes a script and returns the shape it produced.  Call it inside a
/// job: the job's cancel token stops OpenCASCADE operations, and `cancel`
/// (the same token) stops the script between operations.
pub fn compile(
    src: &str,
    limits: &ScriptLimits,
    cancel: &CancelToken,
) -> Result<Compiled, ApiError> {
    let start = Instant::now();
    let output = Output::default();
    let mut engine = engine(limits, cancel.clone(), output.clone());

    let drawn: Rc<RefCell<Option<Shape>>> = Rc::default();
    let slot = drawn.clone();
    engine.register_fn(
        "draw",
        move |value: Dynamic| -> Result<(), Box<EvalAltResult>> {
            if !is_shaped(&value) {
                return Err(format!(
                    "draw() needs a shape (or a selection, sketch or array of shapes), \
                     not a value of type `{}`",
                    value.type_name()
                )
                .into());
            }
            let shape = to_shape(value)?;
            let mut slot = slot.borrow_mut();
            if slot.is_some() {
                return Err("draw() may only be called once".into());
            }
            *slot = Some(shape);
            Ok(())
        },
    );

    let ast = engine
        .compile(src)
        .map_err(|e| ApiError::Script(e.to_string()))?;
    let result = engine
        .eval_ast::<Dynamic>(&ast)
        .map_err(|e| map_eval_error(*e, limits, cancel))?;

    let drawn = drawn.borrow_mut().take();
    let shape = match drawn {
        Some(shape) => shape,
        None if is_shaped(&result) => {
            to_shape(result).map_err(|e| map_eval_error(*e, limits, cancel))?
        }
        None => {
            return Err(ApiError::Script(format!(
                "script must call draw(shape) or evaluate to a shape, \
                 but it evaluated to a value of type `{}`",
                result.type_name()
            )));
        }
    };
    if shape.vertices().is_empty() {
        return Err(ApiError::Unprocessable(format!(
            "the script produced an empty {} with no faces, edges or vertices; \
             a boolean may have removed everything",
            shape.shape_type()
        )));
    }

    let output = std::mem::take(&mut *output.borrow_mut());
    Ok(Compiled {
        shape,
        output,
        script_ms: start.elapsed().as_secs_f64() * 1e3,
    })
}

fn map_eval_error(e: EvalAltResult, limits: &ScriptLimits, cancel: &CancelToken) -> ApiError {
    match error_kind(&e) {
        Some(ErrorKind::Cancelled) => return ApiError::cancelled(),
        // Scripts cannot touch files, but the kind is mapped like an export's.
        Some(ErrorKind::Io) => return ApiError::ExportFailed(e.to_string()),
        _ => {}
    }
    match e {
        EvalAltResult::ErrorTerminated(..) if cancel.is_cancelled() => ApiError::cancelled(),
        EvalAltResult::ErrorTooManyOperations(pos) => {
            let at = if pos.is_none() {
                String::new()
            } else {
                format!(" at {pos}")
            };
            ApiError::LimitExceeded(format!(
                "script exceeded its budget of {} operations{at}",
                limits.max_operations
            ))
        }
        EvalAltResult::ErrorDataTooLarge(what, pos) => {
            ApiError::LimitExceeded(format!("script exceeded a size limit: {what} ({pos})"))
        }
        EvalAltResult::ErrorStackOverflow(pos) => {
            ApiError::LimitExceeded(format!("script exceeded the call depth limit ({pos})"))
        }
        other => ApiError::Script(other.to_string()),
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use scratchcad_occt_rhai::{Error, ShapeType, rhai::Position, with_cancel};

    fn limits() -> ScriptLimits {
        ScriptLimits {
            max_operations: 100_000,
            max_string_size: 4096,
        }
    }

    fn run(src: &str) -> Result<Compiled, ApiError> {
        compile(src, &limits(), &CancelToken::new())
    }

    fn script_error(src: &str) -> String {
        match run(src) {
            Err(ApiError::Script(m)) => m,
            Err(other) => panic!("expected a script error for {src}, got {other:?}"),
            Ok(_) => panic!("expected a script error for {src}"),
        }
    }

    #[test]
    fn draw_and_expression_forms() {
        let a = run("draw(box(1, 2, 3))").unwrap();
        let b = run("box(1, 2, 3)").unwrap();
        assert_eq!(a.shape.volume().unwrap(), b.shape.volume().unwrap());
        assert_eq!(a.shape.shape_type(), ShapeType::Solid);
        // draw() wins over the final expression
        let c = run("draw(cube(2)); sphere(1)").unwrap();
        assert!((c.shape.volume().unwrap() - 8.0).abs() < 1e-9);
    }

    #[test]
    fn selections_sketches_and_arrays_become_shapes() {
        let faces = run("box(1, 1, 1).faces(\"|Z\")").unwrap();
        assert_eq!(faces.shape.shape_type(), ShapeType::Compound);
        // The top and bottom: their normals are parallel to Z
        assert_eq!(faces.shape.faces().len(), 2);
        let wire = run("sketch().move_to(0, 0).line_to(1, 0).line_to(0, 1)").unwrap();
        assert_eq!(wire.shape.shape_type(), ShapeType::Wire);
        let both = run("[cube(1), sphere([5, 0, 0], 1)]").unwrap();
        assert_eq!(both.shape.solids().len(), 2);
        let drawn = run("draw([cube(1)])").unwrap();
        assert_eq!(drawn.shape.solids().len(), 1);
    }

    #[test]
    fn rejects_non_shapes_and_double_draw() {
        assert!(script_error("1 + 2").ends_with("evaluated to a value of type `i64`"));
        assert!(script_error("let s = cube(1);").ends_with("evaluated to a value of type `()`"));
        assert!(script_error("draw(cube(1)); draw(cube(2))").contains("only be called once"));
        assert!(script_error("draw(42)").contains("not a value of type `i64`"));
        assert!(script_error("[1, 2]").contains("expected shapes"));
    }

    #[test]
    fn modelling_errors_are_script_errors_with_their_message() {
        let m = script_error("sphere(-1)");
        assert!(m.contains("invalid argument"), "{m}");
        let m = script_error("cube(1).edges(\"bogus[\")");
        assert!(m.contains("selector"), "{m}");
    }

    #[test]
    fn empty_shapes_are_rejected() {
        let Err(ApiError::Unprocessable(m)) = run("cube(1) - box_centered(10, 10, 10)") else {
            panic!("expected an empty shape error")
        };
        assert!(m.contains("empty compound"), "{m}");
    }

    #[test]
    fn operation_budget_error_gives_limit_and_position() {
        let l = ScriptLimits {
            max_operations: 100,
            ..limits()
        };
        let Err(ApiError::LimitExceeded(m)) =
            compile("let t = 0;\nloop { t += 1; }", &l, &CancelToken::new())
        else {
            panic!("expected a limit error")
        };
        assert!(m.contains("budget of 100 operations at line 2"), "{m}");
    }

    #[test]
    fn sandbox_limits() {
        assert!(matches!(run("loop {}"), Err(ApiError::LimitExceeded(_))));
        assert!(matches!(
            run("import \"/etc/passwd\" as p; cube(1)"),
            Err(ApiError::Script(_))
        ));
        assert!(matches!(run("eval(\"cube(1)\")"), Err(ApiError::Script(_))));
        assert!(matches!(
            run("fn f(n) { f(n + 1) } f(0)"),
            Err(ApiError::LimitExceeded(_))
        ));
        // Error tags are read-only, so a script cannot forge a cancellation.
        let m = script_error("let e = \"x\"; e.tag = 9; throw e;");
        assert!(m.contains("read-only"), "{m}");
    }

    #[test]
    fn cancellation_interrupts_script() {
        let c = CancelToken::new();
        c.cancel();
        let l = ScriptLimits {
            max_operations: 0, // unlimited
            ..limits()
        };
        assert!(matches!(
            compile("loop {}", &l, &c),
            Err(ApiError::Timeout(_))
        ));
        // An OpenCASCADE operation under a cancelled token fails as cancelled
        let r = with_cancel(&c, || {
            compile("cube(2) - sphere(1)", &l, &CancelToken::new())
        });
        assert!(matches!(r, Err(ApiError::Timeout(_))), "{:?}", r.err());
    }

    #[test]
    fn error_kinds_map_to_api_errors() {
        let c = CancelToken::new();
        let e = |error: Error| *Box::<EvalAltResult>::from(error);
        assert!(matches!(
            map_eval_error(e(Error::Cancelled), &limits(), &c),
            ApiError::Timeout(_)
        ));
        assert!(matches!(
            map_eval_error(e(Error::Io("disk".into())), &limits(), &c),
            ApiError::ExportFailed(m) if m.contains("disk")
        ));
        assert!(matches!(
            map_eval_error(e(Error::OperationFailed("fillet")), &limits(), &c),
            ApiError::Script(m) if m.contains("fillet failed")
        ));
        let terminated = EvalAltResult::ErrorTerminated(Dynamic::UNIT, Position::NONE);
        assert!(matches!(
            map_eval_error(terminated, &limits(), &c),
            ApiError::Script(_)
        ));
        let large = EvalAltResult::ErrorDataTooLarge("array".into(), Position::NONE);
        assert!(matches!(
            map_eval_error(large, &limits(), &c),
            ApiError::LimitExceeded(m) if m.contains("size limit")
        ));
        let ops = EvalAltResult::ErrorTooManyOperations(Position::NONE);
        assert!(matches!(
            map_eval_error(ops, &limits(), &c),
            ApiError::LimitExceeded(m) if m.ends_with("operations")
        ));
    }

    #[test]
    fn captures_print() {
        let out = run("print(\"hi\"); print(cube(2).faces().len()); cube(1)").unwrap();
        assert_eq!(out.output, vec!["hi".to_string(), "6".to_string()]);
        assert!(out.script_ms >= 0.0);
    }

    #[test]
    fn output_is_capped_and_truncated() {
        let out = run("for i in 0..150 { print(i) } cube(1)").unwrap();
        assert_eq!(out.output.len(), MAX_OUTPUT_LINES);
        assert_eq!(out.output[99], "99");

        // Long lines are cut on a char boundary: "é" is two bytes, so 1024
        // bytes falls exactly between characters but 1023 does not.
        let accents = "let s = \"\"; for i in 0..600 { s += \"é\"; }";
        let out = run(&format!("{accents} print(s); cube(1)")).unwrap();
        let line = &out.output[0];
        assert!(line.ends_with('…'));
        assert_eq!(line.len(), MAX_OUTPUT_LINE_LEN + '…'.len_utf8());
        let out = run(&format!("{accents} print(\"a\" + s); cube(1)")).unwrap();
        assert_eq!(
            out.output[0].len(),
            MAX_OUTPUT_LINE_LEN - 1 + '…'.len_utf8()
        );
    }

    #[test]
    fn debug_output_includes_position() {
        let out = run("debug(\"here\"); cube(1)").unwrap();
        assert!(
            out.output[0].starts_with("[line 1, position 1]"),
            "{:?}",
            out.output
        );
        assert!(out.output[0].contains("here"));
    }

    #[test]
    fn string_size_limit() {
        let l = ScriptLimits {
            max_string_size: 64,
            ..limits()
        };
        let r = compile(
            "let s = \"a\"; for i in 0..10 { s += s; } cube(1)",
            &l,
            &CancelToken::new(),
        );
        assert!(matches!(r, Err(ApiError::LimitExceeded(m)) if m.contains("size")));
    }
}
