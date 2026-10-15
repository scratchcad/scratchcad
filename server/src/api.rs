//! HTTP handlers and request / response types for `/v1`
//!
//! The API is stateless: every request carries its Rhai script, which is run
//! in the sandbox and its shape then measured, rendered or exported.  All of
//! that happens inside one job, because shapes cannot leave the thread they
//! were made on; jobs hand back bytes or plain data.

use std::time::Instant;

use axum::{
    Json,
    extract::{Path, State},
    http::{HeaderMap, HeaderName, HeaderValue, StatusCode, header},
    response::{IntoResponse, Response},
};
use scratchcad_occt_rhai::{DVec2, DVec3, Shape};
use serde::{Deserialize, Serialize};

use crate::{
    AppState,
    error::{ApiError, ApiJson},
    export::{self, ExportFormat},
    jobs::{JobCtx, Stage},
    measure::{self, ShapeSummary},
    mesh,
    render::{self, Camera, Mode2d, Mode3d, Rotation, View2d, View3d},
    script::{self, Compiled},
};

const X_COMPUTE_MS: HeaderName = HeaderName::from_static("x-compute-ms");
const X_TRIANGLES: HeaderName = HeaderName::from_static("x-triangle-count");
const X_TOLERANCE: HeaderName = HeaderName::from_static("x-mesh-tolerance");
const X_VIEW_CENTER: HeaderName = HeaderName::from_static("x-view-center");
const X_VIEW_HALF_SIZE: HeaderName = HeaderName::from_static("x-view-half-size");
/// One per warning: the request succeeded, but the result may not be what
/// the caller intended (for example a section plane that misses the part)
const X_WARNING: HeaderName = HeaderName::from_static("x-warning");

////////////////////////////////////////////////////////////////////////////////
// Validation helpers

fn check_script_len(state: &AppState, s: &str) -> Result<(), ApiError> {
    if s.len() > state.config.max_script_bytes {
        return Err(ApiError::LimitExceeded(format!(
            "script is {} bytes; the limit is {}",
            s.len(),
            state.config.max_script_bytes
        )));
    }
    Ok(())
}

/// Runs the script in the sandbox; called inside a job
fn compile(state: &AppState, src: &str, ctx: &JobCtx) -> Result<Compiled, ApiError> {
    script::compile(src, &state.limits, &ctx.cancel)
}

pub(crate) fn finite<const N: usize>(name: &str, v: &[f64; N]) -> Result<(), ApiError> {
    if v.iter().all(|x| x.is_finite()) {
        Ok(())
    } else {
        Err(ApiError::BadRequest(format!("`{name}` must be finite")))
    }
}

pub(crate) fn positive(name: &str, v: f64) -> Result<(), ApiError> {
    if v.is_finite() && v > 0.0 {
        Ok(())
    } else {
        Err(ApiError::BadRequest(format!(
            "`{name}` must be a positive number"
        )))
    }
}

pub(crate) fn dim(name: &str, v: u32, max: u32) -> Result<u32, ApiError> {
    if (1..=max).contains(&v) {
        Ok(v)
    } else {
        Err(ApiError::LimitExceeded(format!(
            "`{name}` must be in 1..={max}"
        )))
    }
}

fn ms_since(start: Instant) -> f64 {
    start.elapsed().as_secs_f64() * 1e3
}

fn ms_header(ms: f64) -> HeaderValue {
    HeaderValue::from_str(&format!("{ms:.3}")).expect("number is a valid header")
}

fn number_header(values: &[f64]) -> HeaderValue {
    let text: Vec<String> = values.iter().map(|v| format!("{v}")).collect();
    HeaderValue::from_str(&text.join(",")).expect("numbers are a valid header")
}

fn add_warnings(headers: &mut HeaderMap, warnings: &[String]) {
    for w in warnings {
        // Header values must be visible ASCII; warnings are written that way,
        // but never drop one over a stray character.
        let ascii: String = w
            .chars()
            .map(|c| {
                if c == ' ' || c.is_ascii_graphic() {
                    c
                } else {
                    '?'
                }
            })
            .collect();
        let value = HeaderValue::from_str(&ascii).expect("sanitized to visible ASCII");
        headers.append(X_WARNING, value);
    }
}

/// The diagonal of the shape's bounding box, which mesh tolerances scale with
fn diagonal(bbox: &scratchcad_occt_rhai::BoundingBox) -> f64 {
    bbox.size().length()
}

////////////////////////////////////////////////////////////////////////////////
// Script validation

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
pub struct ValidateRequest {
    script: String,
}

#[derive(Serialize)]
pub struct ValidateResponse {
    shape: ShapeSummary,
    /// `print` / `debug` output from the script
    output: Vec<String>,
    /// Problems with the shape that will cause trouble later
    warnings: Vec<String>,
    script_ms: f64,
    measure_ms: f64,
}

/// `POST /v1/scripts/validate` — run a script and describe the shape it
/// produces.  Nothing is stored.
pub async fn validate_script(
    State(state): State<AppState>,
    ApiJson(req): ApiJson<ValidateRequest>,
) -> Result<Json<ValidateResponse>, ApiError> {
    check_script_len(&state, &req.script)?;
    let st = state.clone();
    let out = state
        .jobs
        .run(move |ctx| {
            let c = compile(&st, &req.script, ctx)?;
            ctx.set_stage(Stage::Measuring);
            let start = Instant::now();
            let (shape, warnings) = measure::summarize(&c.shape)?;
            Ok(ValidateResponse {
                shape,
                output: c.output,
                warnings,
                script_ms: c.script_ms,
                measure_ms: ms_since(start),
            })
        })
        .await?;
    Ok(Json(out))
}

////////////////////////////////////////////////////////////////////////////////
// Rasterization

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Raster2dRequest {
    script: String,
    width: u32,
    height: u32,
    #[serde(default)]
    mode: Mode2d,
    /// Model-space point at the center of the image; defaults to the middle
    /// of the shape's bounding box
    center: Option<[f64; 2]>,
    /// Half of the visible model-space extent along the image's longer
    /// axis; defaults to just enough to show the bounding box
    half_size: Option<f64>,
}

fn png_response(rendered: Rendered, ms: f64) -> Response {
    let mut headers = HeaderMap::new();
    headers.insert(header::CONTENT_TYPE, HeaderValue::from_static("image/png"));
    headers.insert(X_COMPUTE_MS, ms_header(ms));
    headers.insert(X_VIEW_CENTER, number_header(&rendered.center));
    headers.insert(X_VIEW_HALF_SIZE, number_header(&[rendered.half_size]));
    headers.insert(X_TOLERANCE, number_header(&[rendered.tolerance]));
    add_warnings(&mut headers, &rendered.warnings);
    (headers, rendered.png).into_response()
}

/// A render, and how it was made
struct Rendered {
    png: Vec<u8>,
    center: Vec<f64>,
    half_size: f64,
    tolerance: f64,
    warnings: Vec<String>,
}

/// `POST /v1/raster/2d` — render the cross-section at z = 0 to PNG
pub async fn raster_2d(
    State(state): State<AppState>,
    ApiJson(req): ApiJson<Raster2dRequest>,
) -> Result<Response, ApiError> {
    let max = state.config.max_image_size_2d;
    let (w, h) = (
        dim("width", req.width, max)?,
        dim("height", req.height, max)?,
    );
    if let Some(c) = &req.center {
        finite("center", c)?;
    }
    if let Some(h) = req.half_size {
        positive("half_size", h)?;
    }
    check_script_len(&state, &req.script)?;

    let st = state.clone();
    let (rendered, ms) = state
        .jobs
        .run(move |ctx| {
            let c = compile(&st, &req.script, ctx)?;
            let start = Instant::now();
            ctx.set_stage(Stage::Measuring);
            let bbox = measure::bounding_box(&c.shape)?;
            let view = View2d::framing(
                &bbox,
                (w, h),
                req.mode,
                req.center.map(DVec2::from_array),
                req.half_size,
            );
            let mut warnings = vec![];
            let pixel = 2.0 * view.half_size / f64::from(w.max(h));
            let tolerance = mesh::render_tolerance(pixel, diagonal(&bbox));
            let segments = if bbox.min.z > 0.0 || bbox.max.z < 0.0 {
                warnings.push(format!(
                    "the plane z = 0 misses the part, which spans z = {:.6} to {:.6}; \
                     translate it in the script to see a section",
                    bbox.min.z, bbox.max.z
                ));
                vec![]
            } else {
                ctx.set_stage(Stage::Meshing);
                let welded =
                    mesh::mesh(&c.shape, tolerance, st.config.max_mesh_triangles)?.welded();
                let segments = render::section(&welded);
                if segments.is_empty() {
                    warnings.push(format!(
                        "the section at z = 0 is empty: the part spans z = {:.6} to {:.6} \
                         but has no faces that cross the plane",
                        bbox.min.z, bbox.max.z
                    ));
                }
                segments
            };
            ctx.set_stage(Stage::Rendering);
            let rgba = render::render_2d(&view, &segments, &ctx.cancel)?;
            let png = render::encode_png(&rgba, w, h)?;
            Ok((
                Rendered {
                    png,
                    center: view.center.to_array().to_vec(),
                    half_size: view.half_size,
                    tolerance,
                    warnings,
                },
                ms_since(start),
            ))
        })
        .await?;
    Ok(png_response(rendered, ms))
}

fn default_true() -> bool {
    true
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Raster3dRequest {
    script: String,
    width: u32,
    height: u32,
    #[serde(default)]
    mode: Mode3d,
    /// Draw the sharp edges (shaded and normals modes)
    #[serde(default = "default_true")]
    edges: bool,
    /// Model-space point at the center of the view; defaults to the middle
    /// of the shape's bounding box
    center: Option<[f64; 3]>,
    /// The view spans `center ± half_size` along the image's longer axis;
    /// defaults to just enough to show the whole bounding box
    half_size: Option<f64>,
    #[serde(default)]
    rotation: Rotation,
    /// Perspective strength; 0 is orthographic
    #[serde(default)]
    perspective: f64,
}

/// `POST /v1/raster/3d` — render a 3D view to PNG
pub async fn raster_3d(
    State(state): State<AppState>,
    ApiJson(req): ApiJson<Raster3dRequest>,
) -> Result<Response, ApiError> {
    let max = state.config.max_image_size_3d;
    let (w, h) = (
        dim("width", req.width, max)?,
        dim("height", req.height, max)?,
    );
    if let Some(c) = &req.center {
        finite("center", c)?;
    }
    if let Some(h) = req.half_size {
        positive("half_size", h)?;
    }
    let r = req.rotation;
    finite("rotation", &[r.yaw, r.pitch, r.roll])?;
    if !(0.0..=1.0).contains(&req.perspective) {
        return Err(ApiError::BadRequest(
            "`perspective` must be in 0..=1".into(),
        ));
    }
    check_script_len(&state, &req.script)?;

    let st = state.clone();
    let (rendered, ms) = state
        .jobs
        .run(move |ctx| {
            let c = compile(&st, &req.script, ctx)?;
            let start = Instant::now();
            ctx.set_stage(Stage::Measuring);
            let bbox = measure::bounding_box(&c.shape)?;
            let camera = Camera::framing(
                &bbox,
                (w, h),
                &req.rotation,
                req.perspective,
                req.center.map(DVec3::from_array),
                req.half_size,
            );
            let pixel = 2.0 * camera.half_size / f64::from(w.max(h));
            let tolerance = mesh::render_tolerance(pixel, diagonal(&bbox));
            ctx.set_stage(Stage::Meshing);
            let scene = scene(&c.shape, tolerance, st.config.max_mesh_triangles, req.edges)?;
            ctx.set_stage(Stage::Rendering);
            let view = View3d {
                width: w,
                height: h,
                mode: req.mode,
                camera,
            };
            let rgba = render::render_3d(&view, &scene.mesh, &scene.lines, &bbox, &ctx.cancel)?;
            let png = render::encode_png(&rgba, w, h)?;
            Ok((
                Rendered {
                    png,
                    center: view.camera.center.to_array().to_vec(),
                    half_size: view.camera.half_size,
                    tolerance,
                    warnings: scene.warnings,
                },
                ms_since(start),
            ))
        })
        .await?;
    Ok(png_response(rendered, ms))
}

/// What a 3D render draws
struct Scene {
    /// The faces, with their own normals
    mesh: scratchcad_occt_rhai::Mesh,
    /// The edges drawn over them
    lines: Vec<[DVec3; 2]>,
    warnings: Vec<String>,
}

fn scene(
    shape: &Shape,
    tolerance: f64,
    max_triangles: usize,
    edges: bool,
) -> Result<Scene, ApiError> {
    if shape.faces().is_empty() {
        // Wires and edges have nothing to shade: draw their edges instead.
        let warning = format!(
            "the shape is a {} with no faces, so only its edges are drawn",
            shape.shape_type()
        );
        return Ok(Scene {
            mesh: Default::default(),
            lines: mesh::sampled_edges(shape),
            warnings: vec![warning],
        });
    }
    let shown = mesh::mesh(shape, tolerance, max_triangles)?;
    let lines = if edges {
        mesh::sharp_edges(&shown.welded())
    } else {
        vec![]
    };
    Ok(Scene {
        mesh: shown,
        lines,
        warnings: vec![],
    })
}

////////////////////////////////////////////////////////////////////////////////
// Export

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
pub struct ExportRequest {
    script: String,
    /// Mesh formats only: the largest distance between the mesh and the
    /// true surface.  Defaults to 1e-3 of the bounding-box diagonal.
    tolerance: Option<f64>,
}

/// `POST /v1/export/{format}` — the shape as STEP, IGES, BREP, STL, OBJ or 3MF
pub async fn export(
    State(state): State<AppState>,
    Path(format): Path<String>,
    ApiJson(req): ApiJson<ExportRequest>,
) -> Result<Response, ApiError> {
    let format = ExportFormat::from_extension(&format).ok_or_else(|| {
        ApiError::NotFound(format!(
            "unknown export format `{format}`; expected {}",
            ExportFormat::names()
        ))
    })?;
    if let Some(t) = req.tolerance {
        if !format.is_mesh() {
            return Err(ApiError::BadRequest(format!(
                "`tolerance` only applies to mesh formats (stl, obj and 3mf), not {}",
                format.extension()
            )));
        }
        positive("tolerance", t)?;
    }
    check_script_len(&state, &req.script)?;

    let st = state.clone();
    let (out, ms) = state
        .jobs
        .run(move |ctx| {
            let c = compile(&st, &req.script, ctx)?;
            let start = Instant::now();
            let out = if format.is_mesh() {
                export_mesh(&st, ctx, &c.shape, format, req.tolerance)?
            } else {
                ctx.set_stage(Stage::Exporting);
                Exported {
                    bytes: export::exact(&c.shape, format)?,
                    mesh: None,
                    warnings: vec![],
                }
            };
            Ok((out, ms_since(start)))
        })
        .await?;

    let mut headers = HeaderMap::new();
    headers.insert(
        header::CONTENT_TYPE,
        HeaderValue::from_static(format.media_type()),
    );
    let disposition = format!("attachment; filename=\"shape.{}\"", format.extension());
    headers.insert(
        header::CONTENT_DISPOSITION,
        HeaderValue::from_str(&disposition).expect("ASCII file name"),
    );
    headers.insert(X_COMPUTE_MS, ms_header(ms));
    if let Some((triangles, tolerance)) = out.mesh {
        headers.insert(X_TRIANGLES, HeaderValue::from(triangles));
        headers.insert(X_TOLERANCE, number_header(&[tolerance]));
    }
    add_warnings(&mut headers, &out.warnings);
    Ok((headers, out.bytes).into_response())
}

/// An exported file, with the triangle count and tolerance of a mesh
struct Exported {
    bytes: Vec<u8>,
    mesh: Option<(usize, f64)>,
    warnings: Vec<String>,
}

fn export_mesh(
    state: &AppState,
    ctx: &JobCtx,
    shape: &Shape,
    format: ExportFormat,
    requested: Option<f64>,
) -> Result<Exported, ApiError> {
    ctx.set_stage(Stage::Measuring);
    let bbox = measure::bounding_box(shape)?;
    let (tolerance, warning) = mesh::export_tolerance(requested, diagonal(&bbox));
    let mut warnings: Vec<String> = warning.into_iter().collect();
    if shape.faces().is_empty() {
        return Err(ApiError::EmptyMesh(format!(
            "the shape is a {} with no faces, so its mesh has no triangles; \
             export it as STEP, IGES or BREP, or make faces or solids from it",
            shape.shape_type()
        )));
    }
    if shape.solids().is_empty() {
        warnings.push(format!(
            "the shape is a {} with no solids, so the mesh is not watertight",
            shape.shape_type()
        ));
    }
    ctx.set_stage(Stage::Meshing);
    let welded = mesh::mesh(shape, tolerance, state.config.max_mesh_triangles)?.welded();
    ctx.set_stage(Stage::Exporting);
    let bytes = export::mesh(&welded, format)?;
    tracing::debug!(
        triangles = welded.triangle_count(),
        vertices = welded.vertex_count(),
        tolerance,
        "mesh built"
    );
    Ok(Exported {
        bytes,
        mesh: Some((welded.triangle_count(), tolerance)),
        warnings,
    })
}

////////////////////////////////////////////////////////////////////////////////
// Health

/// `GET /healthz` — liveness
pub async fn healthz() -> &'static str {
    "ok"
}

#[derive(Serialize)]
pub struct Readiness {
    status: &'static str,
    active_jobs: usize,
    job_capacity: usize,
}

/// `GET /readyz` — readiness; 503 once shutdown has begun
pub async fn readyz(State(state): State<AppState>) -> impl IntoResponse {
    let draining = state.is_draining();
    let body = Readiness {
        status: if draining { "draining" } else { "ready" },
        active_jobs: state.jobs.active(),
        job_capacity: state.jobs.capacity(),
    };
    let status = if draining {
        StatusCode::SERVICE_UNAVAILABLE
    } else {
        StatusCode::OK
    };
    (status, Json(body))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn validators() {
        assert!(finite("p", &[0.0, 1.0]).is_ok());
        assert!(finite("p", &[f64::NAN]).is_err());
        assert!(finite("p", &[f64::INFINITY, 0.0]).is_err());
        assert!(positive("s", 0.5).is_ok());
        for bad in [0.0, -1.0, f64::NAN, f64::INFINITY] {
            assert!(positive("s", bad).is_err(), "{bad}");
        }
        assert_eq!(dim("w", 1, 8).unwrap(), 1);
        assert_eq!(dim("w", 8, 8).unwrap(), 8);
        assert!(matches!(dim("w", 0, 8), Err(ApiError::LimitExceeded(_))));
        assert!(matches!(dim("w", 9, 8), Err(ApiError::LimitExceeded(_))));
    }

    #[test]
    fn headers() {
        assert_eq!(number_header(&[1.5, -2.0, 0.25]), "1.5,-2,0.25");
        let mut h = HeaderMap::new();
        add_warnings(&mut h, &["plain".into(), "über".into()]);
        let all: Vec<_> = h.get_all(X_WARNING).iter().collect();
        assert_eq!(all, ["plain", "?ber"]);
    }
}
