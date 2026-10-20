// ISO 1234 2 x 20 split cotter pin: half-round legs bent into an eye at the head
let wire_d = 1.8; // [0.6, 6.0] Pin diameter (mm)
let length = 20.0; // [8.0, 80.0] Leg length (mm)
let eye_r = 1.8; // [1.0, 6.0] Eye radius (mm)
let leg = sketch("XY").move_to(0, 0).hline(wire_d / 2.0).arc_to(0, wire_d / 2.0, -wire_d / 2.0, 0).close().to_face();
let half = leg.extrude([0, 0, length]);
let other = leg.rotate_z(180).extrude([0, 0, length * 0.85]);
let eye = torus(eye_r, wire_d / 2.0).rotate_x(90).translate([0, 0, length + eye_r - 0.1]);
fuse_all([half, other, eye])
