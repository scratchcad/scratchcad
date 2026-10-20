// Notched glue spreader card: 100 x 60 x 2 mm, 3 mm sawtooth notches 2 mm deep along one edge, 8 mm hanging hole
let width = 100.0; // [60.0, 150.0] Spreader width (mm)
let height = 60.0; // [40.0, 90.0] Spreader height (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let notch_pitch = 3.0; // [2.0, 6.0] Notch pitch (mm)
let notch_depth = 2.0; // [1.0, 4.0] Notch depth (mm)
let n = (width / notch_pitch).floor().to_int();
let p = width / n.to_float();
let pts = [[0, 0, 0]];
for i in 0..n {
    pts.push([(i.to_float() + 0.5) * p, notch_depth, 0]);
    pts.push([(i.to_float() + 1.0) * p, 0, 0]);
}
pts.push([width, height, 0]);
pts.push([0, height, 0]);
let card = polygon(pts).to_face().extrude([0, 0, t]);
card - cylinder([width / 2.0, height - 10.0, -1], "Z", 4.0, t + 2.0)
