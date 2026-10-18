# scratchcad-occt-rhai and scratchcad-occt-sys

Script the [OpenCASCADE](https://dev.opencascade.org) CAD kernel with [Rhai](https://rhai.rs).
Write a short script and get a real B-rep solid you can export to STEP, IGES, BREP or STL.

These crates live in the [`crates/`](https://github.com/scratchcad/scratchcad/tree/main/crates)
directory of [scratchcad](https://github.com/scratchcad/scratchcad), whose modelling service runs
on them, and are released with it, under the same version number. Until 2026-10-18 they were
developed in [scratchcad-occt-rs](https://github.com/scratchcad/scratchcad-occt-rs).

```rhai
// mounting_plate.rhai
let plate = box_centered(80, 50, 6).fillet(5, "|Z");

for x in [-1, 1] {
    for y in [-1, 1] {
        plate -= cylinder([x * 32, y * 17, -6], "Z", 2.5, 12);
    }
}

plate.chamfer(0.8, ">Z")
```

```rust
let plate = scratchcad_occt_rhai::eval_shape(&std::fs::read_to_string("mounting_plate.rhai")?)?;
plate.write_step("plate.step")?;
```

## Crates

| crate | what it is |
|-------|------------|
| [`scratchcad-occt-rhai`](https://github.com/scratchcad/scratchcad/tree/main/crates/scratchcad-occt-rhai) | The Rhai scripting API and a matching Rust API. |
| [`scratchcad-occt-sys`](https://github.com/scratchcad/scratchcad/tree/main/crates/scratchcad-occt-sys) | Low-level [cxx](https://cxx.rs) bindings to OpenCASCADE 7.8 that turn C++ exceptions into Rust `Result`s. |

The crates link an installed OpenCASCADE 7.8 (see [Building](#building)), or compile it from
source with the `builtin` feature.

## Usage

```sh
cargo add scratchcad-occt-rhai
```

Run a script with `eval_shape`, or add the functions to your own Rhai `Engine` with `register`.
Scripts only model; your Rust code reads and writes the files:

```rust
let part = scratchcad_occt_rhai::eval_shape(r#"box(40, 30, 5).fillet(2, "|Z")"#)?;
part.write_step("plate.step")?;
```

The same operations are available as a Rust API:

```rust
use scratchcad_occt_rhai::{DVec3, Shape};

let plate = Shape::make_box(40.0, 30.0, 5.0)?;
let hole = Shape::cylinder(4.0, 5.0)?.translate(DVec3::new(20.0, 15.0, 0.0))?;
let part = plate.fillet(2.0, plate.edges().select("|Z")?.shapes())?.cut(&hole)?;
```

### Running scripts you do not trust

Scripts have no functions that read or write files, and `import` loads no modules from disk. A
`CancelToken` stops long OpenCASCADE operations (booleans, shells, meshing, STEP/IGES/BREP
conversion) from another thread; fillets, chamfers and lofts cannot be interrupted once started
(OpenCASCADE 7.8 ignores their progress range) but do not start after a cancel. Shapes convert to
STEP, IGES, BREP or binary STL in memory:

```rust
use scratchcad_occt_rhai::{engine, to_shape, with_cancel, CancelToken, Format, MeshOptions};

let mut engine = engine();
engine.set_max_operations(1_000_000);
let token = CancelToken::new(); // call token.cancel() from another thread to stop the work
let step = with_cancel(&token, || -> Result<Vec<u8>, Box<dyn std::error::Error>> {
    let shape = to_shape(engine.eval(script)?)?;
    Ok(shape.to_bytes(Format::Step, &MeshOptions::new(0.01))?)
})?;
```

`set_message_handler` keeps OpenCASCADE's own console output off stdout. `Shape` is not `Send`:
OpenCASCADE shares sub-shapes between shapes and updates them in place, so use `shape.detach()`
to move a deep copy to another thread, and do not enable Rhai's `sync` feature.

### Learn more

- [Rhai API reference](https://github.com/scratchcad/scratchcad/blob/main/crates/scratchcad-occt-rhai/docs/rhai-api.md):
  every function, selectors and sketches.
- [Example scripts](https://github.com/scratchcad/scratchcad/tree/main/crates/scratchcad-occt-rhai/examples).

## Building

You need a Rust toolchain, CMake, a C++ compiler and OpenCASCADE 7.8 (7.9 is accepted but
untested; 7.6 and older lack the data-exchange libraries the bindings link). CMake looks for it in
the usual system locations and under `DEP_OCCT_ROOT`. Two prebuilt sources:

* **conda-forge**, for Linux (x86-64 and arm64), macOS and Windows. With
  [micromamba](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html):

  ```sh
  micromamba create -y -p /opt/occt -c conda-forge "occt=7.8.1=novtk*"
  export DEP_OCCT_ROOT=/opt/occt
  export LD_LIBRARY_PATH=/opt/occt/lib   # the libraries are shared; programs need to find them
  ```

  This is what CI uses.
* **Debian 13 (trixie)** and Ubuntu 25.04 or newer: `apt install libocct-foundation-dev
  libocct-modeling-data-dev libocct-modeling-algorithms-dev libocct-ocaf-dev
  libocct-data-exchange-dev`. (Debian 12 and Ubuntu 24.04 only have 7.6.)

To compile OpenCASCADE from source instead (about 20 minutes the first time; the result is linked
statically), enable the `builtin` feature: `cargo build --features builtin`.

From the root of the scratchcad repository, run the tests with
`cargo test -p scratchcad-occt-sys -p scratchcad-occt-rhai`.

## Credits

The `scratchcad-occt-sys` bindings started as a fork of `opencascade-sys` from
[bschwind/opencascade-rs](https://github.com/bschwind/opencascade-rs). See
[NOTICE](https://github.com/scratchcad/scratchcad/blob/main/crates/scratchcad-occt-sys/NOTICE)
for the copyright notices.

## License

LGPL-2.1-only, the same as OpenCASCADE. Each crate has its own `LICENSE` and `NOTICE`
([scratchcad-occt-rhai](https://github.com/scratchcad/scratchcad/tree/main/crates/scratchcad-occt-rhai),
[scratchcad-occt-sys](https://github.com/scratchcad/scratchcad/tree/main/crates/scratchcad-occt-sys)).
The rest of scratchcad, outside `crates/`, is licensed under the Apache License 2.0.
