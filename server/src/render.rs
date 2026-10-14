//! A small software rasterizer: shaded 3D views of a mesh, with its sharp
//! edges drawn over it, and the cross-section at z = 0.
//!
//! Both render at twice the requested resolution and average 2x2 blocks, so
//! edges are antialiased.

use scratchcad_occt_rhai::{BoundingBox, CancelToken, DVec2, DVec3, Mesh};
use serde::Deserialize;

use crate::error::ApiError;

/// Supersampling factor along each axis
const SS: usize = 2;
/// Margin around an auto-framed part
const FRAME_MARGIN: f64 = 1.08;
/// Perspective views clip geometry this close to the eye (in units of `w`)
const NEAR_W: f64 = 0.01;
/// Triangles or line segments drawn between checks of the cancel token
const CANCEL_EVERY: usize = 2048;
/// Pixels visited between checks of the cancel token, for large triangles
const CANCEL_PIXELS: usize = 1 << 20;

/// Lambert shading: light from the upper left, a little toward the viewer
const LIGHT: DVec3 = DVec3::new(-0.4, 0.55, 0.75);
const AMBIENT: f64 = 0.25;
const SURFACE: [f64; 3] = [0.74, 0.78, 0.84];
/// The back of an open face is shaded darker
const BACK_SIDE: f64 = 0.7;
const EDGE: [u8; 3] = [32, 34, 40];

#[derive(Deserialize, Debug, Default, Clone, Copy, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum Mode3d {
    /// Grayscale depth: nearer is brighter
    Heightmap,
    /// View-space normals mapped to RGB
    Normals,
    /// Lit, shaded surface
    #[default]
    Shaded,
}

#[derive(Deserialize, Debug, Default, Clone, Copy, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum Mode2d {
    /// The section filled white on black (even-odd rule)
    #[default]
    Mono,
    /// The section's outline, white on black
    Outline,
}

/// Rotation in degrees, composed as yaw (about Y) · roll (about Z) · pitch
/// (about X): pitch acts first, then roll, then yaw
#[derive(Deserialize, Debug, Default, Clone, Copy, PartialEq)]
#[serde(deny_unknown_fields)]
pub struct Rotation {
    #[serde(default)]
    pub yaw: f64,
    #[serde(default)]
    pub pitch: f64,
    #[serde(default)]
    pub roll: f64,
}

fn rotate_x(deg: f64, v: DVec3) -> DVec3 {
    let (s, c) = deg.to_radians().sin_cos();
    DVec3::new(v.x, c * v.y - s * v.z, s * v.y + c * v.z)
}

fn rotate_y(deg: f64, v: DVec3) -> DVec3 {
    let (s, c) = deg.to_radians().sin_cos();
    DVec3::new(c * v.x + s * v.z, v.y, -s * v.x + c * v.z)
}

fn rotate_z(deg: f64, v: DVec3) -> DVec3 {
    let (s, c) = deg.to_radians().sin_cos();
    DVec3::new(c * v.x - s * v.y, s * v.x + c * v.y, v.z)
}

impl Rotation {
    /// Turns a view-space vector into model space
    pub fn apply(&self, v: DVec3) -> DVec3 {
        rotate_y(self.yaw, rotate_z(self.roll, rotate_x(self.pitch, v)))
    }

    /// The view's x, y and z axes in model space
    fn axes(&self) -> [DVec3; 3] {
        [DVec3::X, DVec3::Y, DVec3::Z].map(|a| self.apply(a))
    }
}

/// The camera of a 3D render.
///
/// Screen space is `[-1, 1]` along the image's longer axis, with +x right,
/// +y up and +z toward the viewer, who looks along -z.  A screen point `s`
/// shows the model point `center + half_size * R * s / (1 + perspective * s.z)`,
/// where `R` is the [`Rotation`].
#[derive(Debug, Clone, PartialEq)]
pub struct Camera {
    pub center: DVec3,
    pub half_size: f64,
    pub perspective: f64,
    axes: [DVec3; 3],
}

impl Camera {
    pub fn new(center: DVec3, half_size: f64, rotation: &Rotation, perspective: f64) -> Self {
        Self {
            center,
            half_size,
            perspective,
            axes: rotation.axes(),
        }
    }

    /// A camera that frames the bounding box: centered on it (unless
    /// `center` is given) and, unless `half_size` is given, just large enough
    /// that every corner of the box is in view.
    pub fn framing(
        bbox: &BoundingBox,
        size: (u32, u32),
        rotation: &Rotation,
        perspective: f64,
        center: Option<DVec3>,
        half_size: Option<f64>,
    ) -> Self {
        let center = center.unwrap_or_else(|| bbox.center());
        let mut camera = Self::new(center, 1.0, rotation, perspective);
        camera.half_size = half_size.unwrap_or_else(|| {
            let (sx, sy) = aspect(size);
            // A corner u (in view axes, unscaled) lands on screen at
            // u.x / (h - p u.z), which must stay within the image's sx.
            let needed = corners(bbox)
                .map(|c| {
                    let u = camera.to_view(c);
                    let depth = perspective * u.z;
                    (u.x.abs() / sx + depth).max(u.y.abs() / sy + depth)
                })
                .into_iter()
                .fold(0.0, f64::max);
            if needed > 1e-12 {
                needed * FRAME_MARGIN
            } else {
                // A single point
                1.0
            }
        });
        camera
    }

    /// Model point to view space: `R^T (m - center) / half_size`
    fn to_view(&self, m: DVec3) -> DVec3 {
        let d = (m - self.center) / self.half_size;
        DVec3::new(
            d.dot(self.axes[0]),
            d.dot(self.axes[1]),
            d.dot(self.axes[2]),
        )
    }

    /// Model direction to view space
    fn dir_to_view(&self, n: DVec3) -> DVec3 {
        DVec3::new(
            n.dot(self.axes[0]),
            n.dot(self.axes[1]),
            n.dot(self.axes[2]),
        )
    }

    /// `w`, which divides view space into screen space
    fn w(&self, v: DVec3) -> f64 {
        1.0 - self.perspective * v.z
    }
}

/// The screen-space extent of the image along x and y: 1 along the longer
/// axis, less along the shorter
fn aspect((width, height): (u32, u32)) -> (f64, f64) {
    let long = f64::from(width.max(height));
    (f64::from(width) / long, f64::from(height) / long)
}

fn corners(b: &BoundingBox) -> [DVec3; 8] {
    std::array::from_fn(|i| {
        DVec3::new(
            if i & 1 == 0 { b.min.x } else { b.max.x },
            if i & 2 == 0 { b.min.y } else { b.max.y },
            if i & 4 == 0 { b.min.z } else { b.max.z },
        )
    })
}

/// Maps screen space to supersampled pixel coordinates (y down)
#[derive(Clone, Copy)]
struct Pixels {
    width: usize,
    height: usize,
    /// Pixels per screen unit
    scale: f64,
}

impl Pixels {
    fn new(width: u32, height: u32) -> Self {
        let (width, height) = (width as usize * SS, height as usize * SS);
        Self {
            width,
            height,
            scale: width.max(height) as f64 / 2.0,
        }
    }

    fn to_pixel(self, x: f64, y: f64) -> (f64, f64) {
        (
            x * self.scale + self.width as f64 / 2.0,
            self.height as f64 / 2.0 - y * self.scale,
        )
    }

    fn len(&self) -> usize {
        self.width * self.height
    }
}

/// A vertex in view space, with its view-space normal
#[derive(Clone, Copy)]
struct ViewVertex {
    v: DVec3,
    n: DVec3,
}

/// A vertex projected to (supersampled) pixels
#[derive(Clone, Copy)]
struct Projected {
    x: f64,
    y: f64,
    /// Screen depth: larger is nearer
    z: f64,
    /// 1 / w, for perspective-correct interpolation
    inv_w: f64,
    n: DVec3,
}

/// Clips a convex polygon to the part of view space in front of the eye
fn clip_near(poly: &[ViewVertex], camera: &Camera) -> Vec<ViewVertex> {
    if camera.perspective == 0.0 {
        return poly.to_vec();
    }
    let dist = |p: &ViewVertex| camera.w(p.v) - NEAR_W;
    let mut out = Vec::with_capacity(poly.len() + 1);
    for (i, a) in poly.iter().enumerate() {
        let b = &poly[(i + 1) % poly.len()];
        let (da, db) = (dist(a), dist(b));
        if da >= 0.0 {
            out.push(*a);
        }
        if (da >= 0.0) != (db >= 0.0) {
            let t = da / (da - db);
            out.push(ViewVertex {
                v: a.v.lerp(b.v, t),
                n: a.n.lerp(b.n, t),
            });
        }
    }
    out
}

fn project(p: &ViewVertex, camera: &Camera, px: &Pixels) -> Projected {
    let inv_w = 1.0 / camera.w(p.v);
    let (x, y) = px.to_pixel(p.v.x * inv_w, p.v.y * inv_w);
    Projected {
        x,
        y,
        z: p.v.z * inv_w,
        inv_w,
        n: p.n,
    }
}

/// What the rasterizer produces at supersampled resolution
struct Frame {
    px: Pixels,
    depth: Vec<f32>,
    color: Vec<[u8; 3]>,
    /// Whether anything (surface or edge) covers the sample
    covered: Vec<bool>,
}

impl Frame {
    fn new(px: Pixels) -> Self {
        Self {
            px,
            depth: vec![f32::NEG_INFINITY; px.len()],
            color: vec![[0; 3]; px.len()],
            covered: vec![false; px.len()],
        }
    }

    /// Averages each block of SS x SS samples into one RGBA pixel
    fn downsample(&self) -> Vec<u8> {
        let (w, h) = (self.px.width / SS, self.px.height / SS);
        let mut out = Vec::with_capacity(w * h * 4);
        for y in 0..h {
            for x in 0..w {
                let (mut sum, mut n) = ([0u32; 3], 0u32);
                for sy in 0..SS {
                    for sx in 0..SS {
                        let i = (y * SS + sy) * self.px.width + x * SS + sx;
                        if self.covered[i] {
                            for (s, c) in sum.iter_mut().zip(self.color[i]) {
                                *s += u32::from(c);
                            }
                            n += 1;
                        }
                    }
                }
                if n == 0 {
                    out.extend([0; 4]);
                } else {
                    // Color averages over covered samples; alpha is coverage.
                    out.extend(sum.map(|s| (s / n) as u8));
                    out.push((n * 255 / (SS * SS) as u32) as u8);
                }
            }
        }
        out
    }
}

fn shade(mode: Mode3d, n: DVec3, back: bool) -> [u8; 3] {
    match mode {
        Mode3d::Normals => (n * 0.5 + 0.5)
            .to_array()
            .map(|c| (c * 255.0).round() as u8),
        // Filled in from the depth buffer once everything is drawn
        Mode3d::Heightmap => [0; 3],
        Mode3d::Shaded => {
            let lambert = n.dot(LIGHT.normalize()).max(0.0);
            let mut light = AMBIENT + (1.0 - AMBIENT) * lambert;
            if back {
                light *= BACK_SIDE;
            }
            SURFACE.map(|c| (c * light * 255.0).round().clamp(0.0, 255.0) as u8)
        }
    }
}

/// Draws one triangle; returns how many pixels it visited
fn rasterize(frame: &mut Frame, tri: [Projected; 3], mode: Mode3d) -> usize {
    let [a, b, c] = tri;
    // Twice the signed area in pixels; pixels have y down, so a triangle
    // that is counter-clockwise (front-facing) on screen has a negative one.
    let area = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
    if area == 0.0 || !area.is_finite() {
        return 0;
    }
    let back = area > 0.0;
    let px = frame.px;
    let lo = |v: f64| (v - 0.5).ceil().max(0.0) as usize;
    let x0 = lo(a.x.min(b.x).min(c.x));
    let y0 = lo(a.y.min(b.y).min(c.y));
    let x1 = ((a.x.max(b.x).max(c.x) - 0.5).floor() + 1.0).clamp(0.0, px.width as f64) as usize;
    let y1 = ((a.y.max(b.y).max(c.y) - 0.5).floor() + 1.0).clamp(0.0, px.height as f64) as usize;
    let edge = |p: &Projected, q: &Projected, x: f64, y: f64| {
        ((q.x - p.x) * (y - p.y) - (q.y - p.y) * (x - p.x)) / area
    };
    for y in y0..y1 {
        let cy = y as f64 + 0.5;
        for x in x0..x1 {
            let cx = x as f64 + 0.5;
            let (wa, wb, wc) = (
                edge(&b, &c, cx, cy),
                edge(&c, &a, cx, cy),
                edge(&a, &b, cx, cy),
            );
            if wa < 0.0 || wb < 0.0 || wc < 0.0 {
                continue;
            }
            let z = wa * a.z + wb * b.z + wc * c.z;
            let i = y * px.width + x;
            if z as f32 <= frame.depth[i] {
                continue;
            }
            frame.depth[i] = z as f32;
            frame.covered[i] = true;
            // Normals interpolate linearly in view space, not on screen
            let (pa, pb, pc) = (wa * a.inv_w, wb * b.inv_w, wc * c.inv_w);
            let mut n = ((a.n * pa + b.n * pb + c.n * pc) / (pa + pb + pc)).normalize_or_zero();
            if back {
                n = -n;
            }
            frame.color[i] = shade(mode, n, back);
        }
    }
    x1.saturating_sub(x0) * y1.saturating_sub(y0)
}

/// Draws a line segment over the surfaces, hidden where a surface is nearer
/// than the line by more than `bias`
fn draw_line(frame: &mut Frame, a: Projected, b: Projected, bias: f64) {
    let px = frame.px;
    let steps = (b.x - a.x).abs().max((b.y - a.y).abs()).ceil().min(1e5) as usize + 1;
    for k in 0..=steps {
        let t = k as f64 / steps as f64;
        let (x, y) = (a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t);
        let (cx, cy) = (x.floor(), y.floor());
        if cx < 0.0 || cy < 0.0 || cx >= px.width as f64 || cy >= px.height as f64 {
            continue;
        }
        let z = a.z + (b.z - a.z) * t;
        let center = cy as usize * px.width + cx as usize;
        if f64::from(frame.depth[center]) > z + bias {
            continue;
        }
        // About one output pixel wide
        for (dx, dy) in [(0, 0), (1, 0), (0, 1), (1, 1)] {
            let (sx, sy) = ((x - 0.5).floor() + dx as f64, (y - 0.5).floor() + dy as f64);
            if sx >= 0.0 && sy >= 0.0 && sx < px.width as f64 && sy < px.height as f64 {
                let i = sy as usize * px.width + sx as usize;
                frame.color[i] = EDGE;
                frame.covered[i] = true;
            }
        }
    }
}

/// A 3D view to render
pub struct View3d {
    pub width: u32,
    pub height: u32,
    pub mode: Mode3d,
    pub camera: Camera,
}

/// Renders a mesh (with its own per-face normals) and line segments to RGBA
/// pixels, transparent where nothing is drawn.  `bbox` sets the depth range
/// of the heightmap mode and how far behind a surface a line still shows.
pub fn render_3d(
    view: &View3d,
    mesh: &Mesh,
    lines: &[[DVec3; 2]],
    bbox: &BoundingBox,
    cancel: &CancelToken,
) -> Result<Vec<u8>, ApiError> {
    let camera = &view.camera;
    let mut frame = Frame::new(Pixels::new(view.width, view.height));
    let vertex = |i: usize| ViewVertex {
        v: camera.to_view(mesh.vertices[i]),
        n: camera.dir_to_view(mesh.normals[i]),
    };
    let mut visited = 0;
    for (t, tri) in mesh.indices.as_chunks::<3>().0.iter().enumerate() {
        if t % CANCEL_EVERY == 0 || visited > CANCEL_PIXELS {
            if cancel.is_cancelled() {
                return Err(ApiError::cancelled());
            }
            visited = 0;
        }
        let poly = clip_near(&[vertex(tri[0]), vertex(tri[1]), vertex(tri[2])], camera);
        let projected: Vec<Projected> =
            poly.iter().map(|p| project(p, camera, &frame.px)).collect();
        for k in 1..projected.len().saturating_sub(1) {
            visited += rasterize(
                &mut frame,
                [projected[0], projected[k], projected[k + 1]],
                view.mode,
            );
        }
    }

    // The depth range the part spans on screen
    let depths = corners(bbox).map(|c| {
        let v = camera.to_view(c);
        v.z / camera.w(v).max(NEAR_W)
    });
    let near = depths.iter().copied().fold(f64::NEG_INFINITY, f64::max);
    let far = depths.iter().copied().fold(f64::INFINITY, f64::min);

    match view.mode {
        Mode3d::Heightmap => {
            let range = (near - far).max(1e-12);
            for (c, &z) in frame.color.iter_mut().zip(&frame.depth) {
                let level = ((f64::from(z) - far) / range).clamp(0.0, 1.0);
                *c = [(level * 255.0).round() as u8; 3];
            }
        }
        Mode3d::Shaded | Mode3d::Normals => {
            let bias = 0.01 * (near - far).max(1e-9);
            for (i, [a, b]) in lines.iter().enumerate() {
                if i % CANCEL_EVERY == 0 && cancel.is_cancelled() {
                    return Err(ApiError::cancelled());
                }
                let ends = [a, b].map(|m| ViewVertex {
                    v: camera.to_view(*m),
                    n: DVec3::ZERO,
                });
                if let Some([p, q]) = clip_segment(ends, camera) {
                    let (p, q) = (
                        project(&p, camera, &frame.px),
                        project(&q, camera, &frame.px),
                    );
                    draw_line(&mut frame, p, q, bias);
                }
            }
        }
    }
    Ok(frame.downsample())
}

/// The part of a segment in front of the eye, if any
fn clip_segment([a, b]: [ViewVertex; 2], camera: &Camera) -> Option<[ViewVertex; 2]> {
    let (da, db) = (camera.w(a.v) - NEAR_W, camera.w(b.v) - NEAR_W);
    match (da >= 0.0, db >= 0.0) {
        (true, true) => Some([a, b]),
        (false, false) => None,
        _ => {
            let t = da / (da - db);
            let mid = ViewVertex {
                v: a.v.lerp(b.v, t),
                n: DVec3::ZERO,
            };
            Some(if da >= 0.0 { [a, mid] } else { [mid, b] })
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// Sections

/// The cross-section of a welded mesh with the plane z = 0, as segments.
///
/// A vertex counts as below the plane when z <= 0, so a part resting on the
/// plane gives the outline of its base, and the segments of a closed mesh
/// always form closed loops.
pub fn section(welded: &Mesh) -> Vec<[DVec2; 2]> {
    let mut out = vec![];
    for tri in welded.indices.as_chunks::<3>().0 {
        let p = [0, 1, 2].map(|i| welded.vertices[tri[i]]);
        let above = p.map(|v| v.z > 0.0);
        if above[0] == above[1] && above[1] == above[2] {
            continue;
        }
        let mut ends = [DVec2::ZERO; 2];
        let mut n = 0;
        for (i, j) in [(0, 1), (1, 2), (2, 0)] {
            if above[i] != above[j] {
                let t = -p[i].z / (p[j].z - p[i].z);
                ends[n] = p[i].lerp(p[j], t).truncate();
                n += 1;
            }
        }
        out.push(ends);
    }
    out
}

/// A 2D view: `center ± half_size` along the image's longer axis
pub struct View2d {
    pub width: u32,
    pub height: u32,
    pub mode: Mode2d,
    pub center: DVec2,
    pub half_size: f64,
}

impl View2d {
    /// The view centered on the bounding box's x and y (unless `center` is
    /// given) and, unless `half_size` is given, just large enough to show them
    pub fn framing(
        bbox: &BoundingBox,
        (width, height): (u32, u32),
        mode: Mode2d,
        center: Option<DVec2>,
        half_size: Option<f64>,
    ) -> Self {
        let center = center.unwrap_or_else(|| bbox.center().truncate());
        let half_size = half_size.unwrap_or_else(|| {
            let (sx, sy) = aspect((width, height));
            let ex = (bbox.max.x - center.x)
                .abs()
                .max((bbox.min.x - center.x).abs());
            let ey = (bbox.max.y - center.y)
                .abs()
                .max((bbox.min.y - center.y).abs());
            let needed = (ex / sx).max(ey / sy);
            if needed > 1e-12 {
                needed * FRAME_MARGIN
            } else {
                1.0
            }
        });
        Self {
            width,
            height,
            mode,
            center,
            half_size,
        }
    }
}

/// Renders section segments white on black: filled by the even-odd rule
/// ([`Mode2d::Mono`]) or as an outline
pub fn render_2d(view: &View2d, segments: &[[DVec2; 2]]) -> Vec<u8> {
    let px = Pixels::new(view.width, view.height);
    let to_pixel = |p: DVec2| {
        let s = (p - view.center) / view.half_size;
        let (x, y) = px.to_pixel(s.x, s.y);
        DVec2::new(x, y)
    };
    let segments: Vec<[DVec2; 2]> = segments.iter().map(|s| s.map(to_pixel)).collect();
    let mut covered = vec![false; px.len()];
    match view.mode {
        Mode2d::Mono => {
            // Where each row of sample centers crosses the outline
            let mut crossings: Vec<Vec<f64>> = vec![vec![]; px.height];
            for [a, b] in &segments {
                let (lo, hi) = if a.y < b.y { (a, b) } else { (b, a) };
                // Rows whose center y lies in [lo.y, hi.y)
                let first = (lo.y - 0.5).ceil().max(0.0) as usize;
                let end = ((hi.y - 0.5).ceil().max(0.0) as usize).min(px.height);
                for (row, xs) in crossings.iter_mut().enumerate().take(end).skip(first) {
                    let y = row as f64 + 0.5;
                    xs.push(lo.x + (hi.x - lo.x) * (y - lo.y) / (hi.y - lo.y));
                }
            }
            for (row, xs) in crossings.iter_mut().enumerate() {
                xs.sort_by(f64::total_cmp);
                for [start, stop] in xs.as_chunks::<2>().0 {
                    let first = (start - 0.5).ceil().max(0.0) as usize;
                    let end = ((stop - 0.5).ceil().max(0.0) as usize).min(px.width);
                    for x in first..end {
                        covered[row * px.width + x] = true;
                    }
                }
            }
        }
        Mode2d::Outline => {
            for [a, b] in &segments {
                let steps = (b.x - a.x).abs().max((b.y - a.y).abs()).ceil().min(1e5) as usize + 1;
                for k in 0..=steps {
                    let p = a.lerp(*b, k as f64 / steps as f64);
                    for (dx, dy) in [(0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (1.0, 1.0)] {
                        let (x, y) = ((p.x - 0.5).floor() + dx, (p.y - 0.5).floor() + dy);
                        if x >= 0.0 && y >= 0.0 && x < px.width as f64 && y < px.height as f64 {
                            covered[y as usize * px.width + x as usize] = true;
                        }
                    }
                }
            }
        }
    }
    let frame = Frame {
        px,
        depth: vec![],
        color: vec![[255; 3]; px.len()],
        covered,
    };
    // White where covered, over an opaque black background
    frame
        .downsample()
        .as_chunks::<4>()
        .0
        .iter()
        .flat_map(|&[.., level]| [level, level, level, 255])
        .collect()
}

////////////////////////////////////////////////////////////////////////////////
// Encoding

/// Encodes RGBA8 pixels as a PNG
pub fn encode_png(rgba: &[u8], width: u32, height: u32) -> Result<Vec<u8>, ApiError> {
    use image::{ImageEncoder, codecs::png::PngEncoder};
    // The encoder panics on a size mismatch; report it as an error instead.
    let expected = width as usize * height as usize * 4;
    if rgba.len() != expected {
        return Err(ApiError::Internal(format!(
            "encoding PNG: expected {expected} bytes for {width}x{height}, got {}",
            rgba.len()
        )));
    }
    let mut out = Vec::new();
    PngEncoder::new(&mut out)
        .write_image(rgba, width, height, image::ExtendedColorType::Rgba8)
        .map_err(|e| ApiError::Internal(format!("encoding PNG: {e}")))?;
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;
    use scratchcad_occt_rhai::eval_shape;

    fn close(a: DVec3, b: [f64; 3]) -> bool {
        a.distance(DVec3::from_array(b)) < 1e-9
    }

    fn unit_box() -> BoundingBox {
        BoundingBox {
            min: DVec3::splat(-1.0),
            max: DVec3::splat(1.0),
        }
    }

    #[test]
    fn rotations_compose_pitch_then_roll_then_yaw() {
        // 90° of yaw (about Y) takes +X to -Z
        let yaw = Rotation {
            yaw: 90.0,
            ..Default::default()
        };
        assert!(close(yaw.apply(DVec3::X), [0.0, 0.0, -1.0]));
        // Pitch 90 tips the view's up (+Y) to the model's +Z, and roll then
        // turns that view about the model's Z axis.
        let front = Rotation {
            pitch: 90.0,
            ..Default::default()
        };
        assert!(close(front.apply(DVec3::Y), [0.0, 0.0, 1.0]));
        assert!(close(front.apply(DVec3::Z), [0.0, -1.0, 0.0]));
        let right = Rotation {
            pitch: 90.0,
            roll: 90.0,
            ..Default::default()
        };
        assert!(close(right.apply(DVec3::Z), [1.0, 0.0, 0.0]));
        assert!(close(right.apply(DVec3::Y), [0.0, 0.0, 1.0]));
    }

    #[test]
    fn camera_maps_view_space_like_the_formula() {
        let r = Rotation {
            yaw: 30.0,
            pitch: -20.0,
            roll: 5.0,
        };
        let camera = Camera::new(DVec3::new(1.0, 2.0, 3.0), 2.0, &r, 0.0);
        let m = DVec3::new(2.0, -1.0, 0.5);
        let v = camera.to_view(m);
        assert!((camera.center + r.apply(v) * 2.0).distance(m) < 1e-12);
        assert_eq!(camera.w(v), 1.0);
        // Perspective: nearer (larger z) points have a smaller w, so they
        // spread further out on screen
        let p = Camera::new(DVec3::ZERO, 1.0, &Rotation::default(), 0.5);
        assert!(p.w(DVec3::new(0.0, 0.0, 1.0)) < p.w(DVec3::new(0.0, 0.0, -1.0)));
    }

    #[test]
    fn framing_fits_the_box_along_the_constraining_axis() {
        let r = Rotation::default();
        let c = Camera::framing(&unit_box(), (100, 100), &r, 0.0, None, None);
        assert!(close(c.center, [0.0; 3]));
        assert!((c.half_size - FRAME_MARGIN).abs() < 1e-12);
        // A wide image is constrained by its height
        let c = Camera::framing(&unit_box(), (200, 100), &r, 0.0, None, None);
        assert!((c.half_size - 2.0 * FRAME_MARGIN).abs() < 1e-12);
        // Perspective needs room for the near corners, which appear larger
        let c = Camera::framing(&unit_box(), (100, 100), &r, 0.5, None, None);
        assert!((c.half_size - 1.5 * FRAME_MARGIN).abs() < 1e-12);
        // Given values win
        let c = Camera::framing(&unit_box(), (100, 100), &r, 0.0, Some(DVec3::X), Some(7.0));
        assert!(close(c.center, [1.0, 0.0, 0.0]) && c.half_size == 7.0);
        // A point gets a unit view
        let point = BoundingBox {
            min: DVec3::ZERO,
            max: DVec3::ZERO,
        };
        assert_eq!(
            Camera::framing(&point, (10, 10), &r, 0.0, None, None).half_size,
            1.0
        );
        let v = View2d::framing(&point, (10, 10), Mode2d::Mono, None, None);
        assert_eq!(v.half_size, 1.0);
        let v = View2d::framing(&unit_box(), (50, 100), Mode2d::Mono, None, None);
        assert!((v.half_size - 2.0 * FRAME_MARGIN).abs() < 1e-12);
    }

    fn render_with(
        script: &str,
        mode: Mode3d,
        rotation: Rotation,
        perspective: f64,
        edges: bool,
    ) -> Vec<u8> {
        let shape = eval_shape(script).unwrap();
        let bbox = shape.bounding_box().unwrap();
        let mesh = shape.mesh(0.01).unwrap();
        let lines = if edges {
            crate::mesh::sharp_edges(&mesh.welded())
        } else {
            vec![]
        };
        let view = View3d {
            width: 32,
            height: 32,
            mode,
            camera: Camera::framing(&bbox, (32, 32), &rotation, perspective, None, None),
        };
        render_3d(&view, &mesh, &lines, &bbox, &CancelToken::new()).unwrap()
    }

    fn render(script: &str, mode: Mode3d, rotation: Rotation, perspective: f64) -> Vec<u8> {
        render_with(script, mode, rotation, perspective, true)
    }

    fn pixels(img: &[u8]) -> &[[u8; 4]] {
        img.as_chunks::<4>().0
    }

    fn pixel(img: &[u8], x: usize, y: usize) -> [u8; 4] {
        let i = (y * 32 + x) * 4;
        [img[i], img[i + 1], img[i + 2], img[i + 3]]
    }

    #[test]
    fn renders_a_sphere_in_every_mode() {
        for mode in [Mode3d::Shaded, Mode3d::Normals, Mode3d::Heightmap] {
            for perspective in [0.0, 0.7] {
                let img = render("sphere(1)", mode, Rotation::default(), perspective);
                assert_eq!(img.len(), 32 * 32 * 4);
                let center = pixel(&img, 16, 16);
                assert_eq!(center[3], 255, "{mode:?}");
                assert_eq!(pixel(&img, 0, 0), [0; 4], "{mode:?}");
                if mode == Mode3d::Normals {
                    // Facing the viewer: +z, blue
                    assert!(
                        center[2] > 250 && center[0].abs_diff(128) < 12,
                        "{center:?}"
                    );
                }
                if mode == Mode3d::Heightmap {
                    assert!(center[0] > 240, "{center:?}");
                }
            }
        }
    }

    #[test]
    fn shaded_cube_shows_its_edges() {
        let r = Rotation {
            yaw: 30.0,
            pitch: -20.0,
            roll: 0.0,
        };
        let with = render_with("box_centered(2, 2, 2)", Mode3d::Shaded, r, 0.0, true);
        let without = render_with("box_centered(2, 2, 2)", Mode3d::Shaded, r, 0.0, false);
        let darker = pixels(&with)
            .iter()
            .zip(pixels(&without))
            .filter(|(a, b)| a[0] < b[0])
            .count();
        // Nine visible edges, each about 15 pixels long
        assert!(darker > 60, "{darker}");
        // Three faces face the viewer, each lit differently
        let mut shades: Vec<u8> = pixels(&without)
            .iter()
            .filter(|p| p[3] == 255)
            .map(|p| p[0])
            .collect();
        shades.sort_unstable();
        shades.dedup();
        assert!(shades.len() >= 3, "{shades:?}");
    }

    #[test]
    fn near_plane_clips_geometry_behind_the_eye() {
        let shape = eval_shape("box_centered(2, 2, 2)").unwrap();
        let bbox = shape.bounding_box().unwrap();
        let mesh = shape.mesh(0.1).unwrap();
        let lines = crate::mesh::sharp_edges(&mesh.welded());
        // The eye (at view z = 1 / perspective = 1) is inside the box
        let view = View3d {
            width: 16,
            height: 16,
            mode: Mode3d::Shaded,
            camera: Camera::new(DVec3::ZERO, 1.0, &Rotation::default(), 1.0),
        };
        let img = render_3d(&view, &mesh, &lines, &bbox, &CancelToken::new()).unwrap();
        assert_eq!(img.len(), 16 * 16 * 4);
        // Looking out from inside, the far wall's inside fills the view
        assert!(pixels(&img).iter().all(|p| p[3] == 255));
    }

    #[test]
    fn segments_clip_at_the_near_plane() {
        let camera = Camera::new(DVec3::ZERO, 1.0, &Rotation::default(), 1.0);
        let at = |z: f64| ViewVertex {
            v: DVec3::new(0.0, 0.0, z),
            n: DVec3::ZERO,
        };
        assert!(clip_segment([at(2.0), at(3.0)], &camera).is_none());
        let [a, b] = clip_segment([at(0.0), at(3.0)], &camera).unwrap();
        assert_eq!(a.v.z, 0.0);
        assert!((b.v.z - (1.0 - NEAR_W)).abs() < 1e-12);
        let [a, _] = clip_segment([at(3.0), at(0.0)], &camera).unwrap();
        assert!((a.v.z - (1.0 - NEAR_W)).abs() < 1e-12);
        let orthographic = Camera::new(DVec3::ZERO, 1.0, &Rotation::default(), 0.0);
        assert_eq!(clip_near(&[at(5.0)], &orthographic).len(), 1);
    }

    #[test]
    fn cancelled_renders_stop() {
        let shape = eval_shape("sphere(1)").unwrap();
        let bbox = shape.bounding_box().unwrap();
        let mesh = shape.mesh(0.1).unwrap();
        let view = View3d {
            width: 8,
            height: 8,
            mode: Mode3d::Shaded,
            camera: Camera::framing(&bbox, (8, 8), &Rotation::default(), 0.0, None, None),
        };
        let cancel = CancelToken::new();
        cancel.cancel();
        assert!(matches!(
            render_3d(&view, &mesh, &[], &bbox, &cancel),
            Err(ApiError::Timeout(_))
        ));
        let empty = Mesh::default();
        let lines = [[DVec3::ZERO, DVec3::X]];
        assert!(matches!(
            render_3d(&view, &empty, &lines, &bbox, &cancel),
            Err(ApiError::Timeout(_))
        ));
    }

    #[test]
    fn sections_of_a_box() {
        // Resting on the plane: the section is the base's outline
        let welded = eval_shape("box(4, 2, 3)")
            .unwrap()
            .mesh(0.1)
            .unwrap()
            .welded();
        let segments = section(&welded);
        let length: f64 = segments.iter().map(|[a, b]| a.distance(*b)).sum();
        assert!((length - 12.0).abs() < 1e-9, "{length}");
        // Entirely above or below: nothing
        let above = eval_shape("box(1, 1, 1).translate([0, 0, 1])").unwrap();
        assert!(section(&above.mesh(0.1).unwrap().welded()).is_empty());
    }

    fn section_image(script: &str, mode: Mode2d, size: (u32, u32)) -> Vec<u8> {
        let shape = eval_shape(script).unwrap();
        let bbox = shape.bounding_box().unwrap();
        let segments = section(&shape.mesh(0.01).unwrap().welded());
        let view = View2d::framing(&bbox, size, mode, None, None);
        render_2d(&view, &segments)
    }

    #[test]
    fn mono_sections_fill_by_the_even_odd_rule() {
        // A square plate with a round hole in the middle
        let img = section_image(
            "box_centered(10, 10, 2) - cylinder([0, 0, -5], \"Z\", 2, 10)",
            Mode2d::Mono,
            (40, 20),
        );
        assert_eq!(img.len(), 40 * 20 * 4);
        let at = |x: usize, y: usize| &img[(y * 40 + x) * 4..(y * 40 + x) * 4 + 4];
        assert_eq!(at(20, 10), [0, 0, 0, 255], "the hole");
        assert_eq!(at(13, 10), [255, 255, 255, 255], "the plate");
        assert_eq!(at(2, 10), [0, 0, 0, 255], "outside");
        assert!(pixels(&img).iter().all(|p| p[3] == 255));
    }

    #[test]
    fn outline_sections_draw_only_the_boundary() {
        let img = section_image("box_centered(10, 10, 2)", Mode2d::Outline, (32, 32));
        let lit = pixels(&img).iter().filter(|p| p[0] > 0).count();
        // About four sides of 29 pixels, one or two pixels wide
        assert!((80..=300).contains(&lit), "{lit}");
        assert_eq!(&img[(16 * 32 + 16) * 4..][..4], [0, 0, 0, 255]);
    }

    #[test]
    fn png_encoding_checks_the_size() {
        let png = encode_png(&[0; 16], 2, 2).unwrap();
        assert!(png.starts_with(b"\x89PNG"));
        assert!(matches!(
            encode_png(&[0; 15], 2, 2),
            Err(ApiError::Internal(_))
        ));
    }
}
