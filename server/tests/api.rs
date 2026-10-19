use std::time::{Duration, Instant};

use axum::{
    Router,
    body::Body,
    http::{HeaderMap, Request, StatusCode, header},
};
use clap::Parser;
use http_body_util::BodyExt;
use scratchcad::{AppState, config::Config, jobs::Worker};
use serde_json::{Value, json};
use tower::ServiceExt;

/// A 20 mm cube centered on the origin
const CUBE: &str = "draw(box_centered(20, 20, 20))";

/// A plate resting on z = 0 with a hole through it
const PLATE: &str = "let plate = box_centered(40, 20, 4).translate([0, 0, 2]);
                     plate - cylinder([0, 0, -1], \"Z\", 4, 10)";

/// Many booleans, for timeout tests
const HEAVY: &str = "let s = sphere(10);
                     for i in 0..100000 { s = s - cylinder([i % 7, 0, -20], \"Z\", 0.5, 40); }
                     s";

fn state_with(args: &[&str]) -> AppState {
    let config = Config::parse_from(std::iter::once("scratchcad").chain(args.iter().copied()));
    config.validate().unwrap();
    AppState::new(config, Worker::at(env!("CARGO_BIN_EXE_scratchcad")))
}

fn app_with(args: &[&str]) -> Router {
    scratchcad::router(state_with(args))
}

fn app() -> Router {
    app_with(&[])
}

async fn send(app: &Router, req: Request<Body>) -> (StatusCode, HeaderMap, Vec<u8>) {
    let res = app.clone().oneshot(req).await.unwrap();
    let status = res.status();
    let headers = res.headers().clone();
    let bytes = res.into_body().collect().await.unwrap().to_bytes().to_vec();
    (status, headers, bytes)
}

async fn call(
    app: &Router,
    method: &str,
    uri: &str,
    body: Option<Value>,
) -> (StatusCode, HeaderMap, Vec<u8>) {
    let mut req = Request::builder().method(method).uri(uri);
    let body = match body {
        Some(v) => {
            req = req.header(header::CONTENT_TYPE, "application/json");
            Body::from(serde_json::to_vec(&v).unwrap())
        }
        None => Body::empty(),
    };
    send(app, req.body(body).unwrap()).await
}

async fn post(app: &Router, uri: &str, body: Value) -> (StatusCode, HeaderMap, Vec<u8>) {
    call(app, "POST", uri, Some(body)).await
}

/// POSTs and asserts a 200, returning the headers and body
async fn post_ok(app: &Router, uri: &str, body: Value) -> (HeaderMap, Vec<u8>) {
    let (s, h, b) = post(app, uri, body).await;
    assert_eq!(s, StatusCode::OK, "{uri}: {}", String::from_utf8_lossy(&b));
    (h, b)
}

fn json_body(b: &[u8]) -> Value {
    serde_json::from_slice(b).unwrap_or_else(|e| panic!("{e}: {}", String::from_utf8_lossy(b)))
}

/// Asserts an error response with the given status and error code
fn assert_error(r: &(StatusCode, HeaderMap, Vec<u8>), status: StatusCode, code: &str) {
    assert_eq!(r.0, status, "{}", String::from_utf8_lossy(&r.2));
    assert_eq!(r.1[header::CONTENT_TYPE], "application/json");
    let v = json_body(&r.2);
    assert_eq!(v["error"]["code"], code, "{v}");
    assert!(
        v["error"]["message"]
            .as_str()
            .is_some_and(|m| !m.is_empty())
    );
}

/// The message of an error response
fn error_message(r: &(StatusCode, HeaderMap, Vec<u8>)) -> String {
    json_body(&r.2)["error"]["message"]
        .as_str()
        .unwrap()
        .to_owned()
}

fn header_str<'a>(h: &'a HeaderMap, name: &str) -> &'a str {
    h[name].to_str().unwrap()
}

fn header_numbers(h: &HeaderMap, name: &str) -> Vec<f64> {
    header_str(h, name)
        .split(',')
        .map(|v| v.parse().unwrap())
        .collect()
}

fn warnings(h: &HeaderMap) -> Vec<String> {
    h.get_all("x-warning")
        .iter()
        .map(|v| v.to_str().unwrap().to_owned())
        .collect()
}

fn png(b: &[u8]) -> image::RgbaImage {
    image::load_from_memory(b).unwrap().to_rgba8()
}

////////////////////////////////////////////////////////////////////////////////
// Health and middleware

#[tokio::test]
async fn health_and_readiness() {
    let app = app();
    let (s, h, b) = call(&app, "GET", "/healthz", None).await;
    assert_eq!(s, StatusCode::OK);
    assert_eq!(b, b"ok");
    assert!(h.contains_key("x-request-id"));
    assert_eq!(h[header::X_CONTENT_TYPE_OPTIONS], "nosniff");
    assert_eq!(h[header::CACHE_CONTROL], "no-store");

    let (s, _, b) = call(&app, "GET", "/readyz", None).await;
    assert_eq!(s, StatusCode::OK);
    let v = json_body(&b);
    assert_eq!(v["status"], "ready");
    assert_eq!(v["active_jobs"], 0);
    assert_eq!(v["job_capacity"], 4);
}

#[tokio::test]
async fn draining_fails_readiness_and_rejects_jobs() {
    let state = state_with(&[]);
    let app = scratchcad::router(state.clone());
    state.start_draining();
    assert!(state.is_draining());

    let (s, _, b) = call(&app, "GET", "/readyz", None).await;
    assert_eq!(s, StatusCode::SERVICE_UNAVAILABLE);
    assert_eq!(json_body(&b)["status"], "draining");

    // Liveness is unaffected, but no new work is accepted
    let (s, _, _) = call(&app, "GET", "/healthz", None).await;
    assert_eq!(s, StatusCode::OK);
    let r = post(&app, "/v1/scripts/validate", json!({ "script": CUBE })).await;
    assert_error(&r, StatusCode::SERVICE_UNAVAILABLE, "overloaded");
    assert_eq!(r.1[header::RETRY_AFTER], "1");
}

#[tokio::test]
async fn request_id_is_propagated() {
    let req = Request::builder()
        .uri("/healthz")
        .header("x-request-id", "my-trace-id")
        .body(Body::empty())
        .unwrap();
    let (_, h, _) = send(&app(), req).await;
    assert_eq!(h["x-request-id"], "my-trace-id");
}

#[tokio::test]
async fn unknown_routes_and_methods() {
    let app = app();
    let r = call(&app, "GET", "/nope", None).await;
    assert_error(&r, StatusCode::NOT_FOUND, "not_found");
    assert_eq!(error_message(&r), "not found");

    // The API is stateless: the old script-store routes do not exist, and
    // there is no field to evaluate any more
    for uri in ["/v1/scripts", "/v1/eval"] {
        let r = post(&app, uri, json!({ "script": CUBE })).await;
        assert_error(&r, StatusCode::NOT_FOUND, "not_found");
    }

    let (s, _, _) = call(&app, "GET", "/v1/scripts/validate", None).await;
    assert_eq!(s, StatusCode::METHOD_NOT_ALLOWED);
}

////////////////////////////////////////////////////////////////////////////////
// Script validation

#[tokio::test]
async fn validate_describes_the_shape() {
    let app = app();
    let (_, b) = post_ok(
        &app,
        "/v1/scripts/validate",
        json!({ "script": "print(\"hello\"); debug(1); box(10, 20, 30)" }),
    )
    .await;
    let v = json_body(&b);
    let s = &v["shape"];
    assert_eq!(s["type"], "solid");
    assert_eq!(
        [&s["solids"], &s["faces"], &s["edges"], &s["vertices"]],
        [1, 6, 12, 8]
    );
    assert_eq!(s["valid"], true);
    assert_eq!(s["bounding_box"]["size"], json!([10.0, 20.0, 30.0]));
    assert_eq!(s["bounding_box"]["max"], json!([10.0, 20.0, 30.0]));
    assert!(s["bounding_box"]["min"].is_array());
    assert!((s["volume"].as_f64().unwrap() - 6000.0).abs() < 1e-6);
    assert!((s["area"].as_f64().unwrap() - 2200.0).abs() < 1e-6);
    assert!((s["center"][2].as_f64().unwrap() - 15.0).abs() < 1e-9);
    assert_eq!(v["output"][0], "hello");
    assert!(v["output"][1].as_str().unwrap().ends_with('1'));
    assert_eq!(v["warnings"], json!([]));
    assert!(v["script_ms"].as_f64().unwrap() >= 0.0);
    assert!(v["measure_ms"].as_f64().unwrap() >= 0.0);
    assert!(v.get("script_id").is_none());

    // Same script twice gives the same answer; nothing is remembered
    let (_, b2) = post_ok(&app, "/v1/scripts/validate", json!({ "script": PLATE })).await;
    let (_, b3) = post_ok(&app, "/v1/scripts/validate", json!({ "script": PLATE })).await;
    assert_eq!(json_body(&b2)["shape"], json_body(&b3)["shape"]);
}

#[tokio::test]
async fn validate_can_leave_out_mass_properties() {
    let app = app();
    let (_, b) = post_ok(
        &app,
        "/v1/scripts/validate",
        json!({ "script": "box(10, 20, 30)", "mass_properties": false }),
    )
    .await;
    let s = &json_body(&b)["shape"];
    assert_eq!(s["bounding_box"]["size"], json!([10.0, 20.0, 30.0]));
    for field in ["volume", "area", "center"] {
        assert!(s.get(field).is_none(), "{field} should be left out: {s}");
    }
}

#[tokio::test]
async fn validate_warns_about_shapes_without_solids() {
    let (_, b) = post_ok(
        &app(),
        "/v1/scripts/validate",
        json!({ "script": "circle(5)" }),
    )
    .await;
    let v = json_body(&b);
    assert_eq!(v["shape"]["type"], "wire");
    assert_eq!(v["shape"]["volume"], 0.0);
    let w = v["warnings"][0].as_str().unwrap();
    assert!(w.starts_with("the shape has no solids"), "{w}");
}

#[tokio::test]
async fn script_errors() {
    let app = app();
    let cases = [
        ("let a = ;", "script_error"),                    // parse error
        ("undefined_fn(1)", "script_error"),              // runtime error
        ("1 + 2", "script_error"),                        // not a shape
        ("draw(cube(1)); draw(cube(2))", "script_error"), // double draw
        ("cube(1).fillet(5)", "script_error"),            // OpenCASCADE failure
        ("cube(1).edges(\"|Q\")", "script_error"),        // bad selector
        ("loop {}", "limit_exceeded"),                    // operation budget
        ("fn f(n) { f(n + 1) } f(0)", "limit_exceeded"),  // call depth
        ("cube(1) - cube(2)", "unprocessable"),           // nothing left
    ];
    for (script, code) in cases {
        let r = post(&app, "/v1/scripts/validate", json!({ "script": script })).await;
        assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, code);
    }

    // Errors report a position
    let r = post(
        &app,
        "/v1/scripts/validate",
        json!({ "script": "cube(1) +" }),
    )
    .await;
    assert!(error_message(&r).contains("line"));
    let r = post(
        &app,
        "/v1/scripts/validate",
        json!({ "script": "let c = cube(1);\nc.fillet(5)" }),
    )
    .await;
    let m = error_message(&r);
    assert!(m.contains("fillet failed") && m.contains("line 2"), "{m}");
}

////////////////////////////////////////////////////////////////////////////////
// 2D sections

#[tokio::test]
async fn raster_2d_modes_and_auto_framing() {
    let app = app();
    for mode in ["mono", "outline"] {
        let (h, b) = post_ok(
            &app,
            "/v1/raster/2d",
            json!({ "script": PLATE, "width": 64, "height": 32, "mode": mode }),
        )
        .await;
        assert_eq!(h[header::CONTENT_TYPE], "image/png");
        assert!(header_str(&h, "x-compute-ms").parse::<f64>().is_ok());
        assert!(header_numbers(&h, "x-mesh-tolerance")[0] > 0.0);
        // Framed on the plate's x and y extent
        assert_eq!(header_numbers(&h, "x-view-center"), [0.0, 0.0]);
        let half = header_numbers(&h, "x-view-half-size")[0];
        assert!((20.0..25.0).contains(&half), "{half}");
        assert!(warnings(&h).is_empty());
        let img = png(&b);
        assert_eq!(img.dimensions(), (64, 32));
        // Opaque, white on black: the hole is black in both modes
        assert!(img.pixels().all(|p| p[3] == 255));
        assert_eq!(img.get_pixel(32, 16).0, [0, 0, 0, 255], "{mode}");
        let white = img.get_pixel(20, 16).0;
        if mode == "mono" {
            assert_eq!(white, [255, 255, 255, 255]);
        } else {
            assert_eq!(white, [0, 0, 0, 255]);
            assert!(img.pixels().any(|p| p[0] == 255));
        }
    }
}

#[tokio::test]
async fn raster_2d_view_transform() {
    let app = app();
    let render = |center: [f64; 2], half_size: f64| {
        post(
            &app,
            "/v1/raster/2d",
            json!({
                "script": "cylinder(5, 2)", "width": 32, "height": 32,
                "center": center, "half_size": half_size,
            }),
        )
    };
    // Centered: the middle is inside (white) and the corner outside (black)
    let (_, h, b) = render([0.0, 0.0], 10.0).await;
    assert_eq!(header_numbers(&h, "x-view-half-size"), [10.0]);
    let img = png(&b);
    assert_eq!(img.get_pixel(16, 16).0, [255, 255, 255, 255]);
    assert_eq!(img.get_pixel(0, 0).0, [0, 0, 0, 255]);

    // Moving the view far away leaves only empty space
    let (_, _, b) = render([100.0, 100.0], 10.0).await;
    assert!(png(&b).pixels().all(|p| p.0 == [0, 0, 0, 255]));

    // Zooming out shrinks the disc
    let (_, _, b) = render([0.0, 0.0], 40.0).await;
    let white = png(&b).pixels().filter(|p| p.0[0] == 255).count();
    assert!(white > 0 && white < 32 * 32 / 10, "{white}");
}

#[tokio::test]
async fn raster_2d_warns_when_the_plane_misses() {
    let app = app();
    let (h, b) = post_ok(
        &app,
        "/v1/raster/2d",
        json!({ "script": "cube(1).translate([0, 0, 5])", "width": 16, "height": 16 }),
    )
    .await;
    let w = warnings(&h);
    assert_eq!(w.len(), 1);
    assert!(w[0].starts_with("the plane z = 0 misses the part"), "{w:?}");
    assert!(png(&b).pixels().all(|p| p.0 == [0, 0, 0, 255]));

    // Touching the plane from below: no faces cross it
    let (h, _) = post_ok(
        &app,
        "/v1/raster/2d",
        json!({ "script": "cube(1).translate([0, 0, -1])", "width": 16, "height": 16 }),
    )
    .await;
    assert!(warnings(&h)[0].starts_with("the section at z = 0 is empty"));
}

#[tokio::test]
async fn raster_2d_work_is_bounded_by_the_image() {
    // Thousands of section segments seen through a microscopic window.
    // Stepping along each one in full would take billions of steps and run
    // past the job budget; drawing is bounded by the image instead.
    let script = "let a = []; for i in 0..100 { a.push(sphere([i * 3, 0, 0], 1)); } a";
    let app = app_with(&["--job-timeout-ms", "20000"]);
    for mode in ["mono", "outline"] {
        let (_, b) = post_ok(
            &app,
            "/v1/raster/2d",
            json!({
                "script": script, "width": 256, "height": 256, "mode": mode,
                "center": [1.0, 0.0], "half_size": 1e-9,
            }),
        )
        .await;
        assert_eq!(png(&b).dimensions(), (256, 256));
    }
}

////////////////////////////////////////////////////////////////////////////////
// 3D renders

#[tokio::test]
async fn raster_3d_modes() {
    let app = app();
    let cases = [
        json!({ "mode": "heightmap" }),
        json!({ "mode": "normals" }),
        json!({ "mode": "normals", "edges": false }),
        json!({ "mode": "shaded" }),
        json!({ "mode": "shaded", "edges": false, "perspective": 0.5 }),
    ];
    for case in cases {
        let mut body = json!({
            "script": "sphere(10)", "width": 48, "height": 48,
            "rotation": { "yaw": 30, "pitch": -20, "roll": 5 },
        });
        body.as_object_mut()
            .unwrap()
            .extend(case.as_object().unwrap().clone());
        let (h, b) = post_ok(&app, "/v1/raster/3d", body).await;
        assert!(warnings(&h).is_empty());
        let img = png(&b);
        assert_eq!(img.dimensions(), (48, 48));
        // Center pixel hits the sphere, corner pixel is transparent background
        assert_eq!(img.get_pixel(24, 24)[3], 255, "{case}");
        assert_eq!(img.get_pixel(0, 0).0, [0, 0, 0, 0], "{case}");
    }
}

#[tokio::test]
async fn raster_3d_frames_the_part_unless_told_otherwise() {
    let app = app();
    let (h, b) = post_ok(
        &app,
        "/v1/raster/3d",
        json!({ "script": "box(10, 10, 10)", "width": 32, "height": 16 }),
    )
    .await;
    assert_eq!(header_numbers(&h, "x-view-center"), [5.0, 5.0, 5.0]);
    // Looking straight down, the wide image is constrained by its height
    let half = header_numbers(&h, "x-view-half-size")[0];
    assert!((10.0..11.0).contains(&half), "{half}");
    let img = png(&b);
    assert!(img.get_pixel(16, 8)[3] == 255);
    assert!(img.get_pixel(0, 8)[3] == 0);

    // An explicit view far from the part is empty
    let (h, b) = post_ok(
        &app,
        "/v1/raster/3d",
        json!({
            "script": "box(10, 10, 10)", "width": 16, "height": 8,
            "center": [100, 100, 100], "half_size": 5, "mode": "heightmap",
        }),
    )
    .await;
    assert_eq!(header_numbers(&h, "x-view-center"), [100.0, 100.0, 100.0]);
    assert_eq!(header_numbers(&h, "x-view-half-size"), [5.0]);
    assert!(png(&b).pixels().all(|p| p.0 == [0, 0, 0, 0]));
}

#[tokio::test]
async fn raster_3d_draws_the_edges_of_wires() {
    let (h, b) = post_ok(
        &app(),
        "/v1/raster/3d",
        json!({ "script": "rect(10, 5)", "width": 32, "height": 32 }),
    )
    .await;
    assert!(warnings(&h)[0].contains("no faces, so only its edges are drawn"));
    let img = png(&b);
    let drawn = img.pixels().filter(|p| p[3] > 0).count();
    assert!(drawn > 40 && drawn < 32 * 32 / 3, "{drawn}");
}

////////////////////////////////////////////////////////////////////////////////
// Export

fn stl_vertex(b: &[u8], tri: usize, vert: usize) -> [f32; 3] {
    let at = 84 + 50 * tri + 12 + 12 * vert;
    let f = |o: usize| f32::from_le_bytes(b[at + o..at + o + 4].try_into().unwrap());
    [f(0), f(4), f(8)]
}

#[tokio::test]
async fn exports_exact_formats() {
    let app = app();
    for (format, media, starts) in [
        ("step", "model/step", &b"ISO-10303-21;"[..]),
        ("stp", "model/step", b"ISO-10303-21;"),
        ("iges", "model/iges", b""),
        ("brep", "application/octet-stream", b"DBRep_DrawableShape"),
    ] {
        let (h, b) = post_ok(
            &app,
            &format!("/v1/export/{format}"),
            json!({ "script": CUBE }),
        )
        .await;
        assert_eq!(h[header::CONTENT_TYPE], media);
        let ext = if format == "stp" { "step" } else { format };
        assert_eq!(
            h[header::CONTENT_DISPOSITION],
            format!("attachment; filename=\"shape.{ext}\"").as_str()
        );
        assert!(b.starts_with(starts), "{format}");
        assert!(b.len() > 500);
        assert!(!h.contains_key("x-triangle-count"));
        assert!(!h.contains_key("x-mesh-tolerance"));
        assert!(header_str(&h, "x-compute-ms").parse::<f64>().is_ok());
    }
}

#[tokio::test]
async fn exports_mesh_formats() {
    let app = app();
    let (h, b) = post_ok(&app, "/v1/export/stl", json!({ "script": "sphere(10)" })).await;
    assert_eq!(h[header::CONTENT_TYPE], "model/stl");
    assert_eq!(
        h[header::CONTENT_DISPOSITION],
        "attachment; filename=\"shape.stl\""
    );
    let tris: usize = header_str(&h, "x-triangle-count").parse().unwrap();
    assert!(tris > 100);
    // The default tolerance is 1e-3 of the bounding box diagonal
    let tolerance = header_numbers(&h, "x-mesh-tolerance")[0];
    assert!((tolerance - 20.0 * 3f64.sqrt() * 1e-3).abs() < 1e-9);
    // Binary STL layout: 80-byte header, u32 count, 50 bytes per triangle
    let count = u32::from_le_bytes(b[80..84].try_into().unwrap()) as usize;
    assert_eq!(count, tris);
    assert_eq!(b.len(), 84 + 50 * tris);
    assert!(warnings(&h).is_empty());
    // Every vertex lies on the sphere, in model coordinates
    for t in 0..tris {
        for v in 0..3 {
            let [x, y, z] = stl_vertex(&b, t, v);
            assert!(((x * x + y * y + z * z).sqrt() - 10.0).abs() < 0.05);
        }
    }

    let (h, b) = post_ok(&app, "/v1/export/obj", json!({ "script": CUBE })).await;
    assert_eq!(h[header::CONTENT_TYPE], "model/obj");
    let text = String::from_utf8(b).unwrap();
    assert_eq!(text.lines().filter(|l| l.starts_with("v ")).count(), 8);
    assert_eq!(text.lines().filter(|l| l.starts_with("f ")).count(), 12);
    assert_eq!(header_str(&h, "x-triangle-count"), "12");

    let (h, b) = post_ok(&app, "/v1/export/3mf", json!({ "script": CUBE })).await;
    assert_eq!(h[header::CONTENT_TYPE], "model/3mf");
    assert_eq!(
        h[header::CONTENT_DISPOSITION],
        "attachment; filename=\"shape.3mf\""
    );
    assert!(b.starts_with(b"PK\x03\x04"));
}

#[tokio::test]
async fn mesh_tolerance() {
    let app = app();
    let triangles = |h: &HeaderMap| -> usize { header_str(h, "x-triangle-count").parse().unwrap() };
    let (coarse, _) = post_ok(
        &app,
        "/v1/export/stl",
        json!({ "script": "sphere(10)", "tolerance": 0.5 }),
    )
    .await;
    let (fine, _) = post_ok(
        &app,
        "/v1/export/stl",
        json!({ "script": "sphere(10)", "tolerance": 0.01 }),
    )
    .await;
    assert_eq!(header_numbers(&coarse, "x-mesh-tolerance"), [0.5]);
    assert!(triangles(&fine) > 4 * triangles(&coarse));

    // Never finer than 1e-5 of the diagonal
    let (h, _) = post_ok(
        &app,
        "/v1/export/obj",
        json!({ "script": "cube(10)", "tolerance": 1e-9 }),
    )
    .await;
    let floor = 10.0 * 3f64.sqrt() * 1e-5;
    assert!((header_numbers(&h, "x-mesh-tolerance")[0] - floor).abs() < 1e-12);
    assert!(warnings(&h)[0].contains("finer than 1e-5"));
}

#[tokio::test]
async fn export_errors() {
    let app = app();
    let r = post(&app, "/v1/export/dxf", json!({ "script": CUBE })).await;
    assert_error(&r, StatusCode::NOT_FOUND, "not_found");
    assert_eq!(
        error_message(&r),
        "unknown export format `dxf`; expected step, iges, brep, stl, obj or 3mf"
    );

    let r = post(
        &app,
        "/v1/export/step",
        json!({ "script": CUBE, "tolerance": 0.1 }),
    )
    .await;
    assert_error(&r, StatusCode::BAD_REQUEST, "bad_request");
    assert!(error_message(&r).contains("only applies to mesh formats"));
    let r = post(
        &app,
        "/v1/export/stl",
        json!({ "script": CUBE, "tolerance": 0 }),
    )
    .await;
    assert_error(&r, StatusCode::BAD_REQUEST, "bad_request");

    // Wires have no triangles; open faces are not watertight
    let r = post(&app, "/v1/export/stl", json!({ "script": "circle(5)" })).await;
    assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "empty_mesh");
    let (h, _) = post_ok(
        &app,
        "/v1/export/3mf",
        json!({ "script": "cube(1).face(\">Z\")" }),
    )
    .await;
    assert!(warnings(&h)[0].contains("not watertight"));
    // Exact formats take wires as they are
    post_ok(&app, "/v1/export/step", json!({ "script": "circle(5)" })).await;
}

#[tokio::test]
async fn face_limit() {
    let app = app_with(&["--max-faces", "5"]);
    for uri in ["/v1/scripts/validate", "/v1/export/step"] {
        let r = post(&app, uri, json!({ "script": CUBE })).await;
        assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
        assert_eq!(
            error_message(&r),
            "the shape has 6 faces; the limit is 5 (simplify it, or draw fewer parts at once)"
        );
    }
    // Wires have no faces
    post_ok(
        &app,
        "/v1/scripts/validate",
        json!({ "script": "circle(5)" }),
    )
    .await;
}

#[tokio::test]
async fn export_size_limit() {
    let app = app_with(&["--max-export-bytes", "1000"]);
    // Binary STL: an 84-byte header and 50 bytes per triangle
    let (_, b) = post_ok(&app, "/v1/export/stl", json!({ "script": CUBE })).await;
    assert_eq!(b.len(), 84 + 12 * 50);
    let r = post(&app, "/v1/export/stl", json!({ "script": "sphere(10)" })).await;
    assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    let m = error_message(&r);
    assert!(m.starts_with("the STL file is "), "{m}");
    assert!(
        m.ends_with("bytes; the limit is 1000 (use a coarser tolerance or a simpler shape)"),
        "{m}"
    );
    let r = post(&app, "/v1/export/step", json!({ "script": CUBE })).await;
    assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    assert!(error_message(&r).ends_with("(simplify the shape)"));
}

#[tokio::test]
async fn triangle_limit() {
    let app = app_with(&["--max-mesh-triangles", "10"]);
    for (uri, extra) in [
        ("/v1/export/stl", json!({})),
        ("/v1/raster/3d", json!({ "width": 8, "height": 8 })),
        ("/v1/raster/2d", json!({ "width": 8, "height": 8 })),
    ] {
        let mut body = json!({ "script": CUBE });
        body.as_object_mut()
            .unwrap()
            .extend(extra.as_object().unwrap().clone());
        let r = post(&app, uri, body).await;
        assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
        assert!(error_message(&r).contains("12 triangles"), "{uri}");
    }
}

////////////////////////////////////////////////////////////////////////////////
// Request validation and limits

#[tokio::test]
async fn raster_and_export_validation_errors() {
    let app = app();
    let bad_request = [
        (
            "/v1/raster/2d",
            json!({ "script": CUBE, "width": 8, "height": 8, "half_size": 0 }),
        ),
        (
            "/v1/raster/2d",
            json!({ "script": CUBE, "width": 8, "height": 8, "half_size": -1 }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 8, "half_size": 0 }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 8, "perspective": 2 }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 8, "perspective": -0.1 }),
        ),
    ];
    for (uri, body) in bad_request {
        let r = post(&app, uri, body.clone()).await;
        assert_error(&r, StatusCode::BAD_REQUEST, "bad_request");
    }

    let too_big = [
        (
            "/v1/raster/2d",
            json!({ "script": CUBE, "width": 100000, "height": 1 }),
        ),
        (
            "/v1/raster/2d",
            json!({ "script": CUBE, "width": 0, "height": 1 }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 3000 }),
        ),
    ];
    for (uri, body) in too_big {
        let r = post(&app, uri, body.clone()).await;
        assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    }

    // Wrong types, missing fields and the old implicit-surface options are
    // JSON errors
    let invalid = [
        ("/v1/raster/2d", json!({ "script": CUBE, "width": 8 })),
        (
            "/v1/raster/2d",
            json!({ "script": CUBE, "width": 8, "height": 8, "mode": "sdf" }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 8, "rotation": { "spin": 1 } }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 8, "ssao": true }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": CUBE, "width": 8, "height": 8, "evaluator": "jit" }),
        ),
        ("/v1/export/stl", json!({ "script": CUBE, "depth": 6 })),
        ("/v1/export/stl", json!({ "tolerance": 1 })),
        ("/v1/scripts/validate", json!({ "script": CUBE, "x": 1 })),
    ];
    for (uri, body) in invalid {
        let r = post(&app, uri, body.clone()).await;
        assert_error(&r, StatusCode::BAD_REQUEST, "invalid_json");
    }
}

#[tokio::test]
async fn malformed_bodies() {
    let app = app();
    let raw = |ct: Option<&str>, body: &str| {
        let mut r = Request::builder()
            .method("POST")
            .uri("/v1/scripts/validate");
        if let Some(ct) = ct {
            r = r.header(header::CONTENT_TYPE, ct);
        }
        r.body(Body::from(body.to_owned())).unwrap()
    };
    let r = send(&app, raw(None, r#"{"script":"cube(1)"}"#)).await;
    assert_error(&r, StatusCode::BAD_REQUEST, "bad_request");
    let r = send(&app, raw(Some("application/json"), "{not json")).await;
    assert_error(&r, StatusCode::BAD_REQUEST, "invalid_json");
    // JSON cannot carry NaN; the literal is a syntax error
    let r = send(
        &app,
        Request::builder()
            .method("POST")
            .uri("/v1/raster/3d")
            .header(header::CONTENT_TYPE, "application/json")
            .body(Body::from(
                r#"{"script":"cube(1)","width":8,"height":8,"center":[NaN,0,0]}"#,
            ))
            .unwrap(),
    )
    .await;
    assert_error(&r, StatusCode::BAD_REQUEST, "invalid_json");
}

#[tokio::test]
async fn body_and_script_limits() {
    let app = app_with(&["--max-body-bytes", "1024", "--max-script-bytes", "512"]);
    let big = "x".repeat(2048);
    let r = post(&app, "/v1/scripts/validate", json!({ "script": big })).await;
    assert_error(&r, StatusCode::PAYLOAD_TOO_LARGE, "payload_too_large");

    // Every endpoint enforces the script size limit
    let script = format!("cube(1){}", " ".repeat(600));
    let bodies = [
        ("/v1/scripts/validate", json!({ "script": script })),
        (
            "/v1/raster/2d",
            json!({ "script": script, "width": 8, "height": 8 }),
        ),
        (
            "/v1/raster/3d",
            json!({ "script": script, "width": 8, "height": 8 }),
        ),
        ("/v1/export/stl", json!({ "script": script })),
        ("/v1/export/step", json!({ "script": script })),
    ];
    for (uri, body) in bodies {
        let r = post(&app, uri, body).await;
        assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    }
}

#[tokio::test]
async fn operation_limit_is_configurable() {
    let script = "let t = 0; for i in 0..200 { t = t + 1; } cube(1)";
    let r = post(
        &app_with(&["--max-script-operations", "100"]),
        "/v1/scripts/validate",
        json!({ "script": script }),
    )
    .await;
    assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    post_ok(&app(), "/v1/scripts/validate", json!({ "script": script })).await;
}

////////////////////////////////////////////////////////////////////////////////
// Timeouts and load shedding

async fn timeout_message(args: &[&str], uri: &str, body: Value) -> String {
    let r = post(&app_with(args), uri, body).await;
    assert_error(&r, StatusCode::GATEWAY_TIMEOUT, "timeout");
    error_message(&r)
}

#[tokio::test]
async fn job_timeout_stops_the_script() {
    let m = timeout_message(
        &["--job-timeout-ms", "100"],
        "/v1/scripts/validate",
        json!({ "script": HEAVY }),
    )
    .await;
    assert_eq!(m, "running the script exceeded the 0.1 s job budget");

    let m = timeout_message(
        &[
            "--job-timeout-ms",
            "50",
            "--max-script-operations",
            "1000000000000",
        ],
        "/v1/scripts/validate",
        json!({ "script": "loop {}" }),
    )
    .await;
    assert_eq!(m, "running the script exceeded the 0.05 s job budget");
}

#[tokio::test]
async fn job_timeout_stops_meshing() {
    // A sphere meshed at the finest tolerance allowed
    let m = timeout_message(
        &["--job-timeout-ms", "300"],
        "/v1/export/stl",
        json!({ "script": "sphere(10)", "tolerance": 1e-9 }),
    )
    .await;
    assert_eq!(m, "meshing exceeded the 0.3 s job budget");
}

#[tokio::test]
async fn job_timeout_stops_rendering() {
    // Twelve triangles, but sixteen million samples to fill
    let m = timeout_message(
        &["--job-timeout-ms", "300"],
        "/v1/raster/3d",
        json!({ "script": CUBE, "width": 2048, "height": 2048 }),
    )
    .await;
    assert_eq!(m, "rendering exceeded the 0.3 s job budget");
}

#[tokio::test]
async fn job_timeout_frees_the_slot_at_once() {
    // Measuring thousands of spheres is OpenCASCADE work that can't be
    // interrupted, but its worker can be killed.
    let app = app_with(&["--job-timeout-ms", "600"]);
    let script = "let a = []; for i in 0..5000 { a.push(sphere([i * 3, 0, 0], 1)); } a";
    let start = Instant::now();
    let r = post(&app, "/v1/scripts/validate", json!({ "script": script })).await;
    assert_error(&r, StatusCode::GATEWAY_TIMEOUT, "timeout");
    assert!(error_message(&r).ends_with("exceeded the 0.6 s job budget"));
    assert!(
        start.elapsed() < Duration::from_secs(3),
        "{:?}",
        start.elapsed()
    );
    let (_, _, b) = call(&app, "GET", "/readyz", None).await;
    assert_eq!(json_body(&b)["active_jobs"], 0);
}

#[tokio::test]
async fn worker_cpu_limit() {
    let app = app_with(&["--worker-cpu-seconds", "1", "--job-timeout-ms", "20000"]);
    let r = post(&app, "/v1/scripts/validate", json!({ "script": HEAVY })).await;
    assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    assert!(
        error_message(&r).starts_with("running the script used more than the worker's 1 s of CPU"),
        "{}",
        error_message(&r)
    );
}

#[tokio::test]
async fn worker_memory_limit() {
    let app = app_with(&["--worker-memory-mib", "100"]);
    // The frame buffers of a 2048 x 2048 render need more than that
    let r = post(
        &app,
        "/v1/raster/3d",
        json!({ "script": CUBE, "width": 2048, "height": 2048 }),
    )
    .await;
    assert_error(&r, StatusCode::UNPROCESSABLE_ENTITY, "limit_exceeded");
    assert!(
        error_message(&r).starts_with("rendering needed more than the worker's 100 MiB of memory"),
        "{}",
        error_message(&r)
    );

    // So does meshing a sphere this finely, and OpenCASCADE may crash
    // rather than fail cleanly when it runs out.
    let r = post(
        &app,
        "/v1/export/stl",
        json!({ "script": "sphere(10)", "tolerance": 5e-4 }),
    )
    .await;
    assert_eq!(r.0, StatusCode::UNPROCESSABLE_ENTITY);
    let code = json_body(&r.2)["error"]["code"].clone();
    let m = error_message(&r);
    assert!(
        code == "worker_crashed" || code == "limit_exceeded",
        "{code}: {m}"
    );
    assert!(m.contains("meshing") && m.contains("100 MiB"), "{m}");
}

#[tokio::test]
async fn overload_returns_503() {
    let app = app_with(&[
        "--max-concurrent-jobs",
        "1",
        "--queue-timeout-ms",
        "20",
        "--job-timeout-ms",
        "2000",
    ]);
    let busy = {
        let app = app.clone();
        tokio::spawn(
            async move { post(&app, "/v1/scripts/validate", json!({ "script": HEAVY })).await },
        )
    };
    tokio::time::sleep(Duration::from_millis(100)).await;
    let r = post(&app, "/v1/scripts/validate", json!({ "script": CUBE })).await;
    assert_error(&r, StatusCode::SERVICE_UNAVAILABLE, "overloaded");
    assert_eq!(r.1[header::RETRY_AFTER], "1");
    busy.abort();
}

////////////////////////////////////////////////////////////////////////////////
// Authentication

#[tokio::test]
async fn bearer_auth() {
    let token = "0123456789abcdef-secret";
    let app = app_with(&["--api-token", token]);

    // Health endpoints stay open for probes
    let (s, _, _) = call(&app, "GET", "/healthz", None).await;
    assert_eq!(s, StatusCode::OK);
    let (s, _, _) = call(&app, "GET", "/readyz", None).await;
    assert_eq!(s, StatusCode::OK);

    let r = post(&app, "/v1/scripts/validate", json!({ "script": CUBE })).await;
    assert_error(&r, StatusCode::UNAUTHORIZED, "unauthorized");
    assert_eq!(r.1[header::WWW_AUTHENTICATE], "Bearer");

    let req = |auth: &str| {
        Request::builder()
            .method("POST")
            .uri("/v1/scripts/validate")
            .header(header::CONTENT_TYPE, "application/json")
            .header(header::AUTHORIZATION, auth)
            .body(Body::from(r#"{"script":"cube(1)"}"#))
            .unwrap()
    };
    for bad in [
        "Bearer wrong-token-wrong-token",
        token,
        "Basic abc",
        &format!("Bearer {token}x"),
    ] {
        let (s, _, _) = send(&app, req(bad)).await;
        assert_eq!(s, StatusCode::UNAUTHORIZED, "{bad}");
    }
    let (s, _, _) = send(&app, req(&format!("Bearer {token}"))).await;
    assert_eq!(s, StatusCode::OK);
}
