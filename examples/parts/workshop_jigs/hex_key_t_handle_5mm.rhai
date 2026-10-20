// T-handle for a 5 mm hex key: 90 mm cross grip 24 mm diameter, 16 mm stem boss 30 mm long, 5 mm across-flats hex socket 35 mm deep
let grip_l = 90.0; // [60.0, 130.0] Grip length (mm)
let grip_d = 24.0; // [18.0, 32.0] Grip diameter (mm)
let stem_l = 30.0; // [15.0, 50.0] Stem length (mm)
let hex = 5.0; // [2.0, 10.0] Hex key size across flats (mm)
let depth = 35.0; // [15.0, 50.0] Socket depth (mm)
let gr = grip_d / 2.0;
let grip = cylinder([-grip_l / 2.0, 0, stem_l + gr], "X", gr, grip_l);
let g = grip.fillet(4.0, grip.edges("%CIRCLE"));
let stem = cylinder(max(8.0, hex + 3.0), stem_l + gr);
let st = stem.chamfer(1.0, stem.edges("<Z"));
let rc = (hex + 0.1) / 3.0.sqrt();
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rc * a.cos(), rc * a.sin(), -1.0]);
}
let socket = polygon(pts).to_face().extrude([0, 0, min(depth, stem_l + grip_d - 4.0) + 1.0]);
g + st - socket
