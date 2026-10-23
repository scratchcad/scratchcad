//! Smooth lofts: a surface through the sections that passes through each exactly, is
//! curvature-continuous everywhere, and never bulges past them.
//!
//! OpenCASCADE's smooth loft fits one polynomial through the sections, which swings past them
//! where they are unevenly spaced (by 8 mm on sections 12 to 16 mm in radius), and fails or creases
//! where sections of several edges meet. This one is built pole by pole. The sections are made
//! compatible B-splines with OpenCASCADE's matching (the same degree and knots, edge `j` over
//! `[j, j + 1]` in u), so the loft is a B-spline surface whose poles at each section are that
//! section's poles. Between sections, each pole follows a quintic: its position, and its first and
//! second derivatives, are given at each section and shared by the segments either side, so the
//! surface is curvature-continuous (C2) across every section, and the knots there say so.
//!
//! The derivatives come from splitting each section's motion in two:
//!
//! * The section moves and turns: its centre (the mean of its poles) follows a path, and its frame
//!   (its plane's normal, and an axis in it turned to fit its poles to the last section's) turns.
//!   Both are estimated from the neighbouring sections, accurately, so coils and threads follow
//!   their helices as closely as the sections allow.
//! * The section changes shape: each pole's position in its section's frame. These, and the
//!   centre's path along the frame's axes, are limited so that each segment's quintic is monotone
//!   and stays between its two values (both derivatives clamped, Hyman's way extended to quintics).
//!   So the loft never goes past its sections: through circles 12, 13, 16 and 11 in radius, its
//!   radius stays between each pair. All of it is measured in the sections' own frames, so the
//!   shape doesn't depend on where the part is or how it is turned.
//!
//! Where the sections are smooth across an edge joint (a line meeting an arc tangentially, or an
//! edge split to match another section), limiting the poles either side of it separately would
//! crease the surface. There the two neighbours are rebuilt from the joint's pole `V` and their
//! difference `Q` as `A = x V + y Q`, `B = x V + (y + 1) Q`, with `x` and `y` interpolated: `A`, `V`
//! and `B` then stay in line at every height, so the faces either side are tangent. Where `x` and
//! `y` vary, the products make those segments degree 10 instead of 5.
//!
//! The shape is one face per section edge, split across where a joint turns smooth or stops being
//! smooth (OpenCASCADE's fillets fail on edges that are tangent for part of their length), with
//! shared edges that are the surface's own iso-curves, exactly.

use crate::{
    error::{invalid, Error, Result},
    shape::Shape,
};
use glam::{DMat3, DQuat, DVec3};
use scratchcad_occt_sys as ffi;

/// A point in homogeneous coordinates: `(w x, w y, w z, w)`.
type H4 = [f64; 4];

/// The Bézier points of a pole's path over one segment, from one section to the next.
type Segment = Vec<H4>;

/// A smooth loft through closed or open wires, as a solid or a shell. With `match_edges`, the
/// wires are given the same number of edges first; otherwise each must be one closed edge.
pub(crate) fn loft(wires: &[Shape], solid: bool, match_edges: bool) -> Result<Shape> {
    let sections = Sections::new(wires, match_edges)?;
    let surface = Surface::through(&sections)?;
    surface.shape(&sections, solid)
}

fn occt(e: cxx::Exception) -> Error {
    // "<exception type>: <message>", from the bindings; the type means nothing to a script.
    let what = e.what();
    let message = what.split_once(": ").map_or(what, |(_, rest)| rest);
    invalid(format!("loft failed: {message}"))
}

/// The sections as compatible B-splines.
struct Sections {
    degree: i32,
    edges: i32,
    closed: bool,
    knots: Vec<f64>,
    mults: Vec<i32>,
    /// Poles and weights, section by section.
    poles: Vec<Vec<DVec3>>,
    weights: Vec<Vec<f64>>,
}

impl Sections {
    fn new(wires: &[Shape], match_edges: bool) -> Result<Self> {
        let mut list = ffi::top_tools::new_list_of_shape();
        for wire in wires {
            list.pin_mut().Append(wire.raw());
        }
        let s = ffi::b_rep_fill::BRepFill_loft_sections(&list, match_edges).map_err(occt)?;
        let nu = s.pole_count() as usize;
        let coords = s.pole_coords().as_slice();
        let weights = s.pole_weights().as_slice();
        let sections = s.section_count() as usize;
        let poles = (0..sections)
            .map(|k| {
                (0..nu)
                    .map(|i| {
                        let at = 3 * (k * nu + i);
                        DVec3::new(coords[at], coords[at + 1], coords[at + 2])
                    })
                    .collect()
            })
            .collect();
        let weights = (0..sections).map(|k| weights[k * nu..(k + 1) * nu].to_vec()).collect();
        Ok(Self {
            degree: s.degree(),
            edges: s.edge_count(),
            closed: s.is_closed(),
            knots: s.knot_values().as_slice().to_vec(),
            mults: s.knot_mults().as_slice().to_vec(),
            poles,
            weights,
        })
    }

    fn count(&self) -> usize {
        self.poles.len()
    }

    fn poles_per_section(&self) -> usize {
        self.poles[0].len()
    }
}

/// A section's frame: its plane's normal `n`, and axes `a` and `b` in it.
#[derive(Clone, Copy)]
struct Frame {
    a: DVec3,
    b: DVec3,
    n: DVec3,
}

impl Frame {
    /// `v` in this frame's axes.
    fn to(&self, v: DVec3) -> DVec3 {
        DVec3::new(v.dot(self.a), v.dot(self.b), v.dot(self.n))
    }

    /// `v`, given in this frame's axes, in the world's.
    fn from(&self, v: DVec3) -> DVec3 {
        self.a * v.x + self.b * v.y + self.n * v.z
    }

    /// The rotation taking this frame to `other`, as its axis times its angle.
    fn rotation_to(&self, other: &Frame) -> DVec3 {
        let from = DMat3::from_cols(self.a, self.b, self.n);
        let to = DMat3::from_cols(other.a, other.b, other.n);
        let mut q = DQuat::from_mat3(&(to * from.transpose())).normalize();
        if q.w < 0.0 {
            q = -q;
        }
        let (axis, angle) = q.to_axis_angle();
        axis * angle
    }
}

/// The surface's poles, weights and knots in v, with the cuts where faces split.
struct Surface {
    /// Poles by index in u, then v; and their weights.
    poles: Vec<Vec<DVec3>>,
    weights: Vec<Vec<f64>>,
    v_degree: i32,
    v_knots: Vec<f64>,
    v_mults: Vec<i32>,
    cuts: Vec<f64>,
}

impl Surface {
    fn through(sec: &Sections) -> Result<Self> {
        let n = sec.count();
        let nu = sec.poles_per_section();
        let t = parameters(&sec.poles)?;
        let h: Vec<f64> = t.windows(2).map(|w| w[1] - w[0]).collect();
        let centres: Vec<DVec3> =
            sec.poles.iter().map(|p| p.iter().sum::<DVec3>() / p.len() as f64).collect();
        let frames = frames(&sec.poles, &centres)?;
        let (omega, alpha) = turning(&frames, &t);
        let (cd, cdd) = path(&centres, &frames, &t, &h);
        let origin = centres[0];

        // Each pole's position and derivatives at each section, homogeneous, and its quintic
        // segments.
        let mut hh = vec![vec![[0.0; 4]; n]; nu];
        let mut hd = hh.clone();
        let mut hdd = hh.clone();
        let mut z: Vec<Vec<Segment>> = Vec::with_capacity(nu);
        for i in 0..nu {
            let local: Vec<DVec3> =
                (0..n).map(|k| frames[k].to(sec.poles[k][i] - centres[k])).collect();
            let mut m = vec![DVec3::ZERO; n];
            let mut a = vec![DVec3::ZERO; n];
            for c in 0..3 {
                let y: Vec<f64> = local.iter().map(|l| l[c]).collect();
                let (mc, ac) = limited(&t, &h, &y);
                for k in 0..n {
                    m[k][c] = mc[k];
                    a[k][c] = ac[k];
                }
            }
            for k in 0..n {
                let p = sec.poles[k][i];
                let r = p - centres[k];
                let lp = frames[k].from(m[k]);
                let lpp = frames[k].from(a[k]);
                let q1 = cd[k] + omega[k].cross(r) + lp;
                let q2 = cdd[k]
                    + alpha[k].cross(r)
                    + omega[k].cross(omega[k].cross(r))
                    + 2.0 * omega[k].cross(lp)
                    + lpp;
                // The weights are interpolated with zero derivatives at the sections, so they stay
                // positive and between their values.
                let w = sec.weights[k][i];
                hh[i][k] = homogeneous((p - origin) * w, w);
                hd[i][k] = homogeneous(q1 * w, 0.0);
                hdd[i][k] = homogeneous(q2 * w, 0.0);
            }
            z.push(segments(&h, &hh[i], &hd[i], &hdd[i]));
        }

        // Joints where the sections are smooth: rebuild the poles either side in line with them.
        let joints = joints(sec, &hh);
        let elevate = joints.iter().any(|j| (0..n - 1).any(|k| j.smooth_on(k) && j.varies(k)));
        let degree = if elevate { 10 } else { 5 };
        let raise = |s: &Segment| if elevate { times(&[1.0; 6], s) } else { s.clone() };
        let mut zp: Vec<Vec<Segment>> =
            z.iter().map(|col| col.iter().map(raise).collect()).collect();
        for joint in &joints {
            joint.rebuild(&t, &h, &hh, &hd, &hdd, &z, &mut zp, elevate);
        }
        let mut cuts = vec![t[0]];
        for (k, &tk) in t.iter().enumerate().take(n - 1).skip(1) {
            if joints.iter().any(|j| j.smooth_on(k - 1) != j.smooth_on(k)) {
                cuts.push(tk);
            }
        }
        cuts.push(t[n - 1]);

        // B-spline poles in v, C2 at the sections: the Bézier points, with the two either side of
        // each inner section replaced by the de Boor point between them.
        let p = degree;
        let mut poles = Vec::with_capacity(nu);
        let mut weights = Vec::with_capacity(nu);
        for col in &zp {
            let mut v: Vec<H4> = col[0][..=p - 2].to_vec();
            for k in 1..n - 1 {
                let rho = h[k] / h[k - 1];
                let (last, before) = (col[k - 1][p - 1], col[k - 1][p - 2]);
                v.push(std::array::from_fn(|c| last[c] + rho * (last[c] - before[c])));
                v.extend_from_slice(&col[k][2..=p - 2]);
            }
            v.extend_from_slice(&col[n - 2][p - 1..=p]);
            poles.push(
                v.iter().map(|q| DVec3::new(q[0], q[1], q[2]) / q[3] + origin).collect::<Vec<_>>(),
            );
            weights.push(v.iter().map(|q| q[3]).collect::<Vec<_>>());
        }
        if sec.closed {
            // The seam: the last column of poles is the first, exactly.
            poles[nu - 1] = poles[0].clone();
            weights[nu - 1] = weights[0].clone();
        }
        let mut v_mults = vec![p as i32 - 2; n];
        v_mults[0] = p as i32 + 1;
        v_mults[n - 1] = p as i32 + 1;
        Ok(Self { poles, weights, v_degree: p as i32, v_knots: t, v_mults, cuts })
    }

    fn shape(&self, sec: &Sections, solid: bool) -> Result<Shape> {
        let flat: Vec<f64> = self.poles.iter().flatten().flat_map(|p| [p.x, p.y, p.z]).collect();
        let weights: Vec<f64> = self.weights.iter().flatten().copied().collect();
        let shape = ffi::b_rep_fill::BRepFill_loft_shape(
            sec.degree,
            &sec.knots,
            &sec.mults,
            self.v_degree,
            &self.v_knots,
            &self.v_mults,
            &flat,
            &weights,
            sec.edges,
            sec.closed,
            &self.cuts,
            solid,
        )
        .map_err(occt)?;
        Shape::from_unique(shape)
    }
}

fn homogeneous(v: DVec3, w: f64) -> H4 {
    [v.x, v.y, v.z, w]
}

/// Chord-length parameters: the mean distance between matching poles of consecutive sections.
fn parameters(poles: &[Vec<DVec3>]) -> Result<Vec<f64>> {
    let mut t = vec![0.0];
    for (k, pair) in poles.windows(2).enumerate() {
        let gap = pair[0].iter().zip(&pair[1]).map(|(a, b)| a.distance(*b)).sum::<f64>()
            / pair[0].len() as f64;
        if gap <= 0.0 {
            return Err(invalid(format!(
                "loft failed: sections {} and {} are the same; leave out one of them",
                k + 1,
                k + 2
            )));
        }
        t.push(t[k] + gap);
    }
    Ok(t)
}

/// Each section's frame: its normal (Newell's, over its poles), and an axis in its plane, the
/// first section's pointing at its first pole, each next one's carried over and turned about the
/// normal by the rotation that best fits the section's poles to the last's.
fn frames(poles: &[Vec<DVec3>], centres: &[DVec3]) -> Result<Vec<Frame>> {
    let size = poles[0].iter().map(|p| p.distance(centres[0])).fold(0.0, f64::max);
    let mut frames: Vec<Frame> = Vec::with_capacity(poles.len());
    for (k, (section, &c)) in poles.iter().zip(centres).enumerate() {
        let count = section.len();
        let mut n: DVec3 =
            (0..count).map(|i| (section[i] - c).cross(section[(i + 1) % count] - c)).sum();
        if n.length() <= 1e-12 * size * size {
            return Err(invalid(format!(
                "loft failed: section {} is straight, so no plane says how the loft turns there; a \
                 smooth loft needs every section to span a plane. Use ruled_loft for straight \
                 sections",
                k + 1
            )));
        }
        n = n.normalize();
        let a = match frames.last() {
            Some(last) => {
                if n.dot(last.n) < 0.0 {
                    n = -n;
                }
                let carried = (last.a - n * last.a.dot(n)).normalize();
                let b = n.cross(carried);
                // The best-fit turn about the normal from the last section's poles to these.
                let (mut cos, mut sin) = (0.0, 0.0);
                for (p, q) in poles[k - 1].iter().zip(section) {
                    let p = last.to(*p - centres[k - 1]);
                    let q = *q - c;
                    let (qx, qy) = (q.dot(carried), q.dot(b));
                    cos += p.x * qx + p.y * qy;
                    sin += p.x * qy - p.y * qx;
                }
                let turn = if cos == 0.0 && sin == 0.0 { 0.0 } else { sin.atan2(cos) };
                carried * turn.cos() + b * turn.sin()
            },
            None => {
                let off = |p: &DVec3| *p - c - n * (*p - c).dot(n);
                let first = section.iter().map(off).find(|v| v.length() > 1e-9 * size);
                first.unwrap_or(n.any_orthonormal_vector()).normalize()
            },
        };
        frames.push(Frame { a, b: n.cross(a), n });
    }
    Ok(frames)
}

/// The frames' angular velocity and acceleration at each section, from the rotations between
/// them, unwrapped and fitted locally.
fn turning(frames: &[Frame], t: &[f64]) -> (Vec<DVec3>, Vec<DVec3>) {
    let n = frames.len();
    let steps: Vec<DVec3> = frames.windows(2).map(|f| f[0].rotation_to(&f[1])).collect();
    let mut omega = vec![DVec3::ZERO; n];
    let mut alpha = vec![DVec3::ZERO; n];
    for k in 0..n {
        // The rotation from this section's frame to each other, accumulated step by step.
        let mut psi = vec![DVec3::ZERO; n];
        for i in k + 1..n {
            psi[i] = psi[i - 1] + steps[i - 1];
        }
        for i in (0..k).rev() {
            psi[i] = psi[i + 1] - steps[i];
        }
        let (lo, d1, d2) = local_weights(t, k);
        for (j, (w1, w2)) in d1.iter().zip(&d2).enumerate() {
            omega[k] += psi[lo + j] * *w1;
            alpha[k] += psi[lo + j] * *w2;
        }
    }
    (omega, alpha)
}

/// The centres' path: first and second derivatives at each section, limited along each section's
/// axes.
fn path(centres: &[DVec3], frames: &[Frame], t: &[f64], h: &[f64]) -> (Vec<DVec3>, Vec<DVec3>) {
    let n = centres.len();
    let mut m = vec![DVec3::ZERO; n];
    let mut a = vec![DVec3::ZERO; n];
    for c in 0..3 {
        let y: Vec<f64> = centres.iter().map(|p| p[c]).collect();
        let (mc, ac) = estimates(t, h, &y);
        for k in 0..n {
            m[k][c] = mc[k];
            a[k][c] = ac[k];
        }
    }
    for k in 0..n {
        let f = frames[k];
        let mut ml = f.to(m[k]);
        let mut al = f.to(a[k]);
        let left = (k > 0).then(|| (f.to((centres[k] - centres[k - 1]) / h[k - 1]), h[k - 1]));
        let right = (k + 1 < n).then(|| (f.to((centres[k + 1] - centres[k]) / h[k]), h[k]));
        for c in 0..3 {
            limit(
                &mut ml[c],
                &mut al[c],
                left.map(|(d, h)| (d[c], h)),
                right.map(|(d, h)| (d[c], h)),
            );
        }
        m[k] = f.from(ml);
        a[k] = f.from(al);
    }
    (m, a)
}

/// The slopes at the knots of the C2 cubic spline through `y` (not-a-knot; the parabola through
/// three values, the line through two).
fn spline_slopes(h: &[f64], y: &[f64]) -> Vec<f64> {
    let n = y.len();
    let d: Vec<f64> = (0..n - 1).map(|i| (y[i + 1] - y[i]) / h[i]).collect();
    match n {
        2 => return vec![d[0], d[0]],
        3 => {
            let c = 2.0 * (d[1] - d[0]) / (h[0] + h[1]);
            return vec![d[0] - c * h[0] / 2.0, d[0] + c * h[0] / 2.0, d[1] + c * h[1] / 2.0];
        },
        _ => {},
    }
    let (mut sub, mut diag, mut sup, mut b) =
        (vec![0.0; n], vec![0.0; n], vec![0.0; n], vec![0.0; n]);
    diag[0] = h[1];
    sup[0] = h[0] + h[1];
    b[0] = ((h[0] + 2.0 * (h[0] + h[1])) * h[1] * d[0] + h[0] * h[0] * d[1]) / (h[0] + h[1]);
    for k in 1..n - 1 {
        sub[k] = h[k];
        diag[k] = 2.0 * (h[k - 1] + h[k]);
        sup[k] = h[k - 1];
        b[k] = 3.0 * (h[k] * d[k - 1] + h[k - 1] * d[k]);
    }
    let l = n - 1;
    sub[l] = h[l - 1] + h[l - 2];
    diag[l] = h[l - 2];
    b[l] = (h[l - 1] * h[l - 1] * d[l - 2]
        + (2.0 * (h[l - 2] + h[l - 1]) + h[l - 1]) * h[l - 2] * d[l - 1])
        / (h[l - 2] + h[l - 1]);
    for k in 1..n {
        let w = sub[k] / diag[k - 1];
        diag[k] -= w * sup[k - 1];
        b[k] -= w * b[k - 1];
    }
    let mut m = vec![0.0; n];
    m[n - 1] = b[n - 1] / diag[n - 1];
    for k in (0..n - 1).rev() {
        m[k] = (b[k] - sup[k] * m[k + 1]) / diag[k];
    }
    m
}

/// The index of the first of the nearest five knots to knot `k` (all of them, when there are
/// fewer), and weights giving the first and second derivatives at `k` of the polynomial through
/// the values there.
fn local_weights(t: &[f64], k: usize) -> (usize, Vec<f64>, Vec<f64>) {
    let n = t.len();
    let w = n.min(5);
    let lo = k.saturating_sub(2).min(n - w);
    let mut d1 = vec![0.0; w];
    let mut d2 = vec![0.0; w];
    for i in 0..w {
        // The Lagrange basis polynomial of point i, in powers of t - t[k].
        let mut c = vec![1.0];
        let mut den = 1.0;
        for j in (0..w).filter(|&j| j != i) {
            let xj = t[lo + j] - t[k];
            let mut next = vec![0.0; c.len() + 1];
            for (q, cq) in c.iter().enumerate() {
                next[q] -= xj * cq;
                next[q + 1] += cq;
            }
            c = next;
            den *= t[lo + i] - t[lo + j];
        }
        d1[i] = c.get(1).copied().unwrap_or(0.0) / den;
        d2[i] = 2.0 * c.get(2).copied().unwrap_or(0.0) / den;
    }
    (lo, d1, d2)
}

/// Estimates of the first and second derivatives of `y` at the knots `t`: the spline's slopes,
/// and the local polynomial's second derivatives.
fn estimates(t: &[f64], h: &[f64], y: &[f64]) -> (Vec<f64>, Vec<f64>) {
    let m = spline_slopes(h, y);
    let a = (0..t.len())
        .map(|k| {
            let (lo, _, d2) = local_weights(t, k);
            d2.iter().enumerate().map(|(j, w)| w * y[lo + j]).sum()
        })
        .collect();
    (m, a)
}

/// The estimates, limited at every knot.
fn limited(t: &[f64], h: &[f64], y: &[f64]) -> (Vec<f64>, Vec<f64>) {
    let n = y.len();
    let (mut m, mut a) = estimates(t, h, y);
    for k in 0..n {
        let left = (k > 0).then(|| ((y[k] - y[k - 1]) / h[k - 1], h[k - 1]));
        let right = (k + 1 < n).then(|| ((y[k + 1] - y[k]) / h[k], h[k]));
        limit(&mut m[k], &mut a[k], left, right);
    }
    (m, a)
}

/// Limits the first and second derivatives `m` and `a` at a knot, given the chord slope and gap of
/// the segment to its left and to its right, so that every quintic segment is monotone and stays
/// between its end values.
///
/// A quintic's Bézier points are `y0`, `y0 + h m0/5`, `y0 + 2h m0/5 + h² a0/20` from the left, and
/// the same from the right; it is monotone and between its ends if they are, which holds if the
/// first two steps from each end go the segment's way and the third point from each end is no
/// more than halfway. For slopes no steeper than 2.5 times either chord, and 1.25 times their
/// mean weighted by the gaps, those bounds on `a` from the two sides overlap, so `a` can always be
/// clamped to them. Where the values turn back, `m` is 0.
fn limit(m: &mut f64, a: &mut f64, left: Option<(f64, f64)>, right: Option<(f64, f64)>) {
    let sign = |x: f64| {
        if x > 0.0 {
            1.0
        } else if x < 0.0 {
            -1.0
        } else {
            0.0
        }
    };
    *m = match (left, right) {
        (Some((dl, hl)), Some((dr, hr))) => {
            if dl * dr <= 0.0 {
                0.0
            } else {
                let (al, ar) = (dl.abs(), dr.abs());
                let cap = (2.5 * al)
                    .min(2.5 * ar)
                    .min(1.25 * (al / hl + ar / hr) / (1.0 / hl + 1.0 / hr));
                sign(dl) * (sign(dl) * *m).clamp(0.0, cap)
            }
        },
        (Some((d, _)), None) | (None, Some((d, _))) => {
            if d == 0.0 || *m * d <= 0.0 {
                0.0
            } else {
                sign(d) * m.abs().min(2.5 * d.abs())
            }
        },
        (None, None) => 0.0,
    };
    // Bounds on the second derivative from each side, for its value times the side's direction.
    let (mut lo, mut hi) = (f64::NEG_INFINITY, f64::INFINITY);
    let mut bound = |low: f64, high: f64, s: f64| {
        if s > 0.0 {
            lo = lo.max(low);
            hi = hi.min(high);
        } else if s < 0.0 {
            lo = lo.max(-high);
            hi = hi.min(-low);
        } else {
            lo = lo.max(0.0);
            hi = hi.min(0.0);
        }
    };
    if let Some((d, h)) = left {
        let mt = sign(d) * *m;
        bound((8.0 * mt - 10.0 * d.abs()) / h, 4.0 * mt / h, sign(d));
    }
    if let Some((d, h)) = right {
        let mt = sign(d) * *m;
        bound(-4.0 * mt / h, (10.0 * d.abs() - 8.0 * mt) / h, sign(d));
    }
    *a = a.max(lo).min(hi);
}

/// The quintic Bézier points of a scalar over a segment of length `h`, from its value and first
/// and second derivatives at each end.
fn quintic(h: f64, y0: f64, m0: f64, a0: f64, y1: f64, m1: f64, a1: f64) -> [f64; 6] {
    [
        y0,
        y0 + h * m0 / 5.0,
        y0 + 2.0 * h * m0 / 5.0 + h * h * a0 / 20.0,
        y1 - 2.0 * h * m1 / 5.0 + h * h * a1 / 20.0,
        y1 - h * m1 / 5.0,
        y1,
    ]
}

/// The quintic segments of a homogeneous path.
fn segments(h: &[f64], y: &[H4], m: &[H4], a: &[H4]) -> Vec<Segment> {
    (0..h.len())
        .map(|k| {
            let per: [[f64; 6]; 4] = std::array::from_fn(|c| {
                quintic(h[k], y[k][c], m[k][c], a[k][c], y[k + 1][c], m[k + 1][c], a[k + 1][c])
            });
            (0..6).map(|i| std::array::from_fn(|c| per[c][i])).collect()
        })
        .collect()
}

/// The product of a quintic scalar and a quintic path, as degree-10 Bézier points.
fn times(f: &[f64; 6], g: &Segment) -> Segment {
    const C5: [f64; 6] = [1.0, 5.0, 10.0, 10.0, 5.0, 1.0];
    const C10: [f64; 11] = [1.0, 10.0, 45.0, 120.0, 210.0, 252.0, 210.0, 120.0, 45.0, 10.0, 1.0];
    (0..=10usize)
        .map(|i| {
            let mut out = [0.0; 4];
            for j in i.saturating_sub(5)..=i.min(5) {
                let w = C5[j] * C5[i - j] / C10[i] * f[j];
                for c in 0..4 {
                    out[c] += w * g[i - j][c];
                }
            }
            out
        })
        .collect()
}

/// A joint between two poles' columns `a` and `b` around the column `v` of a C0 knot in u (or the
/// seam), with the sections where it is smooth and their `x` and `y`.
struct Joint {
    a: usize,
    v: usize,
    b: usize,
    smooth: Vec<bool>,
    x: Vec<f64>,
    y: Vec<f64>,
}

impl Joint {
    /// Whether the segment from section `k` to the next is smooth at both ends.
    fn smooth_on(&self, k: usize) -> bool {
        self.smooth[k] && self.smooth[k + 1]
    }

    /// Whether `x` or `y` differ between section `k` and the next.
    fn varies(&self, k: usize) -> bool {
        let same = |p: f64, q: f64| (p - q).abs() <= 1e-12 * p.abs().max(1.0);
        !(same(self.x[k], self.x[k + 1]) && same(self.y[k], self.y[k + 1]))
    }

    /// Rebuilds columns `a` and `b` of `zp` so that they stay in line with `v` on every segment
    /// smooth at both ends, matching the first and second derivatives where those segments meet
    /// the others.
    #[allow(clippy::too_many_arguments)]
    fn rebuild(
        &self,
        t: &[f64],
        h: &[f64],
        hh: &[Vec<H4>],
        hd: &[Vec<H4>],
        hdd: &[Vec<H4>],
        z: &[Vec<Segment>],
        zp: &mut [Vec<Segment>],
        elevate: bool,
    ) {
        let n = t.len();
        let (a, v, b) = (self.a, self.v, self.b);
        // x and y with their derivatives over each run of smooth sections.
        let (mut xm, mut xa, mut ym, mut ya) =
            (vec![0.0; n], vec![0.0; n], vec![0.0; n], vec![0.0; n]);
        let mut k0 = 0;
        while k0 < n {
            if !self.smooth[k0] {
                k0 += 1;
                continue;
            }
            let mut k1 = k0;
            while k1 + 1 < n && self.smooth[k1 + 1] {
                k1 += 1;
            }
            if k1 > k0 && (k0..k1).any(|k| self.varies(k)) {
                for (val, m, acc) in [(&self.x, &mut xm, &mut xa), (&self.y, &mut ym, &mut ya)] {
                    let (mr, ar) = limited(&t[k0..=k1], &h[k0..k1], &val[k0..=k1]);
                    m[k0..=k1].copy_from_slice(&mr);
                    acc[k0..=k1].copy_from_slice(&ar);
                }
            }
            k0 = k1 + 1;
        }
        // A's and B's data at each section: derived where a smooth segment meets it.
        let mut data = [
            (hh[a].clone(), hd[a].clone(), hdd[a].clone()),
            (hh[b].clone(), hd[b].clone(), hdd[b].clone()),
        ];
        for k in 0..n {
            let in_run = self.smooth[k]
                && ((k > 0 && self.smooth[k - 1]) || (k + 1 < n && self.smooth[k + 1]));
            if !in_run {
                continue;
            }
            for (side, (y0d, y1d, y2d)) in data.iter_mut().enumerate() {
                for c in 0..4 {
                    let (v0, v1, v2) = (hh[v][k][c], hd[v][k][c], hdd[v][k][c]);
                    let (q0, q1, q2) = (
                        hh[b][k][c] - hh[a][k][c],
                        hd[b][k][c] - hd[a][k][c],
                        hdd[b][k][c] - hdd[a][k][c],
                    );
                    let (x0, x1, x2) = (self.x[k], xm[k], xa[k]);
                    let (y0, y1, y2) = (self.y[k] + side as f64, ym[k], ya[k]);
                    y0d[k][c] = x0 * v0 + y0 * q0;
                    y1d[k][c] = x1 * v0 + x0 * v1 + y1 * q0 + y0 * q1;
                    y2d[k][c] =
                        x2 * v0 + 2.0 * x1 * v1 + x0 * v2 + y2 * q0 + 2.0 * y1 * q1 + y0 * q2;
                }
            }
        }
        let raise = |s: Segment| if elevate { times(&[1.0; 6], &s) } else { s };
        let za = segments(h, &data[0].0, &data[0].1, &data[0].2);
        let zb = segments(h, &data[1].0, &data[1].1, &data[1].2);
        for k in 0..n - 1 {
            let q: Segment =
                (0..6).map(|i| std::array::from_fn(|c| z[b][k][i][c] - z[a][k][i][c])).collect();
            if self.smooth_on(k) && !self.varies(k) {
                // A = x V + y Q with constant x and y.
                let (x, y) = (self.x[k], self.y[k]);
                let mix = |extra: f64| -> Segment {
                    (0..6)
                        .map(|i| std::array::from_fn(|c| x * z[v][k][i][c] + (y + extra) * q[i][c]))
                        .collect()
                };
                zp[a][k] = raise(mix(0.0));
                zp[b][k] = raise(mix(1.0));
            } else if self.smooth_on(k) {
                let scalar = |val: &[f64], m: &[f64], acc: &[f64], extra: f64| {
                    quintic(
                        h[k],
                        val[k] + extra,
                        m[k],
                        acc[k],
                        val[k + 1] + extra,
                        m[k + 1],
                        acc[k + 1],
                    )
                };
                let xv = times(&scalar(&self.x, &xm, &xa, 0.0), &z[v][k]);
                for (side, extra) in [(a, 0.0), (b, 1.0)] {
                    let yq = times(&scalar(&self.y, &ym, &ya, extra), &q);
                    zp[side][k] =
                        (0..=10).map(|i| std::array::from_fn(|c| xv[i][c] + yq[i][c])).collect();
                }
            } else {
                zp[a][k] = raise(za[k].clone());
                zp[b][k] = raise(zb[k].clone());
            }
        }
    }
}

/// The joints of C0 knots in u (and the seam of closed sections) that are smooth in at least one
/// section: where the joint's pole lies strictly between its neighbours, in line with them.
fn joints(sec: &Sections, hh: &[Vec<H4>]) -> Vec<Joint> {
    let n = sec.count();
    let nu = sec.poles_per_section();
    let degree = sec.degree as usize;
    let mut candidates = Vec::new();
    let mut acc = 0;
    for (i, &mult) in sec.mults.iter().enumerate() {
        acc += mult as usize;
        if i > 0 && i + 1 < sec.mults.len() && mult as usize >= degree {
            let v = acc - degree - 1;
            candidates.push((v - 1, v, v + 1));
        }
    }
    if sec.closed {
        candidates.push((nu - 2, 0, 1));
    }
    let mut used = vec![false; nu];
    let mut out = Vec::new();
    for (a, v, b) in candidates {
        let mut joint = Joint { a, v, b, smooth: vec![false; n], x: vec![0.0; n], y: vec![0.0; n] };
        for (k, ((pa, pv), pb)) in hh[a].iter().zip(&hh[v]).zip(&hh[b]).enumerate() {
            if let Some((x, y)) = in_line(pa, pv, pb) {
                joint.smooth[k] = true;
                joint.x[k] = x;
                joint.y[k] = y;
            }
        }
        // A pole can be rebuilt for one joint only (an edge of three poles has one between).
        if joint.smooth.iter().any(|&s| s) && !used[a] && !used[b] {
            used[a] = true;
            used[b] = true;
            out.push(joint);
        }
    }
    out
}

/// `x` and `y` with `A = x V + y (B - A)` if `V` lies strictly between `A` and `B`, in line.
fn in_line(a: &H4, v: &H4, b: &H4) -> Option<(f64, f64)> {
    let q: H4 = std::array::from_fn(|c| b[c] - a[c]);
    let dot = |p: &H4, r: &H4| (0..4).map(|c| p[c] * r[c]).sum::<f64>();
    let (vv, vq, qq, va, qa, aa) =
        (dot(v, v), dot(v, &q), dot(&q, &q), dot(v, a), dot(&q, a), dot(a, a));
    let det = vv * qq - vq * vq;
    if det <= 1e-24 * vv * qq {
        return None;
    }
    let x = (va * qq - qa * vq) / det;
    let y = (qa * vv - va * vq) / det;
    let residual = (0..4).map(|c| (a[c] - x * v[c] - y * q[c]).powi(2)).sum::<f64>().sqrt();
    (residual <= 1e-10 * aa.sqrt() && x > 0.0 && y < 0.0 && y > -1.0).then_some((x, y))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn monotone_between(y0: f64, y1: f64, points: &[f64; 6]) -> bool {
        let up = y1 >= y0;
        points.windows(2).all(|w| if up { w[1] >= w[0] - 1e-12 } else { w[1] <= w[0] + 1e-12 })
    }

    #[test]
    fn limited_quintics_stay_between_their_ends() {
        // #77's radii at its uneven spacing, a peak, a step and a flat run.
        for (t, y) in [
            (vec![0.0, 90.0, 172.0, 180.0], vec![12.0, 13.0, 16.0, 11.0]),
            (vec![0.0, 1.0, 2.0, 3.0, 4.0], vec![0.0, 0.0, 1.0, 1.0, 1.0]),
            (vec![0.0, 10.0, 12.0, 50.0, 52.0, 60.0], vec![10.0, 10.0, 20.0, 20.0, 10.0, 10.0]),
            (vec![0.0, 1.0], vec![3.0, -2.0]),
            (vec![0.0, 1.0, 5.0], vec![0.0, 1.0, 0.5]),
        ] {
            let h: Vec<f64> = t.windows(2).map(|w| w[1] - w[0]).collect();
            let (m, a) = limited(&t, &h, &y);
            for k in 0..h.len() {
                let b = quintic(h[k], y[k], m[k], a[k], y[k + 1], m[k + 1], a[k + 1]);
                assert!(monotone_between(y[k], y[k + 1], &b), "segment {k} of {y:?}: {b:?}");
            }
        }
    }

    #[test]
    fn smooth_data_is_left_alone() {
        // On a parabola sampled evenly, the estimates are exact and within every bound.
        let t: Vec<f64> = (0..6).map(f64::from).collect();
        let y: Vec<f64> = t.iter().map(|x| 1.0 + x + 0.1 * x * x).collect();
        let h = vec![1.0; 5];
        let (m, a) = limited(&t, &h, &y);
        for k in 0..6 {
            assert!((m[k] - (1.0 + 0.2 * t[k])).abs() < 1e-12, "{m:?}");
            assert!((a[k] - 0.2).abs() < 1e-12, "{a:?}");
        }
    }

    #[test]
    fn local_weights_differentiate_polynomials_exactly() {
        let t = [0.0, 0.5, 2.0, 2.5, 4.0, 7.0];
        for k in 0..t.len() {
            let (lo, d1, d2) = local_weights(&t, k);
            let y = |x: f64| 2.0 - x + 3.0 * x * x - 0.5 * x * x * x;
            let m: f64 = d1.iter().enumerate().map(|(j, w)| w * y(t[lo + j])).sum();
            let a: f64 = d2.iter().enumerate().map(|(j, w)| w * y(t[lo + j])).sum();
            let x = t[k];
            assert!((m - (-1.0 + 6.0 * x - 1.5 * x * x)).abs() < 1e-9, "{k}: {m}");
            assert!((a - (6.0 - 3.0 * x)).abs() < 1e-9, "{k}: {a}");
        }
    }

    #[test]
    fn products_of_quintics_multiply() {
        let f = [1.0, 2.0, 0.5, -1.0, 3.0, 2.0];
        let g: Segment = (0..6).map(|i| [i as f64, 1.0, -(i as f64), 2.0]).collect();
        let fg = times(&f, &g);
        let bern = |n: usize, i: usize, s: f64| {
            let c = (1..=n).product::<usize>() as f64
                / ((1..=i).product::<usize>() * (1..=n - i).product::<usize>()) as f64;
            c * s.powi(i as i32) * (1.0 - s).powi((n - i) as i32)
        };
        for s in [0.0, 0.3, 0.7, 1.0] {
            let fv: f64 = (0..6).map(|i| f[i] * bern(5, i, s)).sum();
            for c in 0..4 {
                let gv: f64 = (0..6).map(|i| g[i][c] * bern(5, i, s)).sum();
                let pv: f64 = (0..11).map(|i| fg[i][c] * bern(10, i, s)).sum();
                assert!((pv - fv * gv).abs() < 1e-12);
            }
        }
    }

    /// Reflections run on across a section without a kink where the curvature doesn't jump
    /// there. The second differences either side of a section, `P(t - 2h) - 2 P(t - h) + P(t)`
    /// and `P(t) - 2 P(t + h) + P(t + 2h)`, are `h²` times the second derivative near it: where
    /// that is continuous they differ by a multiple of `h³`, so halving `h` divides the difference
    /// by 8, where a jump in it would only divide it by 4.
    #[test]
    fn lofts_are_curvature_continuous_across_their_sections() {
        let rings: Vec<Shape> = [(0.0, 12.0), (90.0, 13.0), (172.0, 16.0), (180.0, 11.0)]
            .iter()
            .map(|(x, r)| Shape::circle(DVec3::new(*x, 0.0, 0.0), DVec3::X, *r).unwrap())
            .collect();
        let sections = Sections::new(&rings, false).unwrap();
        let surface = Surface::through(&sections).unwrap();
        let lofted = surface.shape(&sections, false).unwrap();
        let faces = lofted.faces();
        assert_eq!(faces.len(), 1);
        let adaptor =
            ffi::b_rep_adaptor::BRepAdaptor_Surface_new(faces.shapes()[0].face().unwrap(), true)
                .unwrap();
        let at = |u: f64, v: f64| {
            let p = ffi::b_rep_adaptor::BRepAdaptor_Surface_value(&adaptor, u, v).unwrap();
            DVec3::new(p.X(), p.Y(), p.Z())
        };
        for &t in &surface.v_knots[1..3] {
            for u in [0.1, 0.35, 0.8] {
                let jump = |h: f64| {
                    let left = at(u, t - 2.0 * h) - 2.0 * at(u, t - h) + at(u, t);
                    let right = at(u, t) - 2.0 * at(u, t + h) + at(u, t + 2.0 * h);
                    (right - left).length()
                };
                let (coarse, fine) = (jump(0.25), jump(0.125));
                assert!(fine < coarse / 6.0, "at t = {t}, u = {u}: {coarse} then {fine}");
            }
        }
    }

    #[test]
    fn in_line_needs_the_middle_pole_between_its_neighbours() {
        let a = [0.0, 0.0, 0.0, 1.0];
        let b = [2.0, 0.0, 0.0, 1.0];
        assert!(in_line(&a, &[1.0, 0.0, 0.0, 1.0], &b).is_some());
        assert!(in_line(&a, &[3.0, 0.0, 0.0, 1.0], &b).is_none());
        assert!(in_line(&a, &[1.0, 0.1, 0.0, 1.0], &b).is_none());
    }
}
