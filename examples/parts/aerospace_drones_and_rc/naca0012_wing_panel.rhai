// NACA 0012 wing panel: 150 mm chord, 300 mm span, 10 mm main spar hole at 25% chord, 6 mm rear spar at 65%
let chord = 150.0; // [80.0, 250.0] Chord (mm)
let span = 300.0; // [100.0, 600.0] Span (mm)
let t = 0.12; // [0.08, 0.18] Thickness ratio
fn half(chord, t, x) { 5.0 * t * chord * (0.2969 * sqrt(x) - 0.1260 * x - 0.3516 * x * x + 0.2843 * x * x * x - 0.1015 * x * x * x * x) }
let pts = [];
for i in 0..=40 { let x = (1.0 + (PI() * i.to_float() / 40.0).cos()) / 2.0; pts.push([chord * x, half(chord, t, x), 0]); }
for i in 1..=40 { let x = (1.0 - (PI() * i.to_float() / 40.0).cos()) / 2.0; pts.push([chord * x, -half(chord, t, x), 0]); }
let outline = wire([spline(pts), line(pts[pts.len() - 1], pts[0])]);
let wing = face(outline).extrude(span);
wing - cylinder([0.25 * chord, 0, -1], "Z", 5.0, span + 2.0) - cylinder([0.65 * chord, 0, -1], "Z", 3.0, span + 2.0)
