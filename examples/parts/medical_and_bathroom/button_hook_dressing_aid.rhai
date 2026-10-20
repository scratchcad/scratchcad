// Button hook dressing aid: 30 mm built-up handle 110 mm long with finger grooves, 1.6 mm steel wire loop 40 mm long and 9 mm wide
let handle_length = 110.0; // [86.0, 150.0] Handle length (mm)
let handle_diameter = 30.0; // [20.0, 33.6] Handle diameter (mm)
let loop_length = 40.0; // [31.0, 60.0] Wire loop length (mm)
let loop_width = 9.0; // [6.0, 12.0] Wire loop width (mm)
let wire_diameter = 1.6; // [1.0, 2.1] Wire diameter (mm)
let rh = handle_diameter / 2.0;
let side = spline([[rh * 0.7, 0, 0], [rh * 0.97, 0, handle_length * 0.25], [rh * 0.9, 0, handle_length * 0.55], [rh * 0.8, 0, handle_length * 0.85], [rh * 0.5, 0, handle_length]]);
let handle = wire([line([0, 0, 0], [rh * 0.7, 0, 0]), side, line([rh * 0.5, 0, handle_length], [0, 0, handle_length]), line([0, 0, handle_length], [0, 0, 0])])
    .to_face().revolve("Z", 360);
for i in 0..3 {
    handle -= torus(rh * 1.02, 2.5).translate([0, 0, handle_length * (0.2 + 0.12 * i.to_float())]);
}
let w = loop_width / 2.0;
let z0 = handle_length - 15.0;
let L = loop_length;
let pts = [[-1.2, 0, z0], [-1.5, 0, handle_length + 2.0], [-w, 0, handle_length + L * 0.4], [-w * 0.6, 0, handle_length + L * 0.85],
           [0, 0, handle_length + L], [w * 0.6, 0, handle_length + L * 0.85], [w, 0, handle_length + L * 0.4], [1.5, 0, handle_length + 2.0], [1.2, 0, z0]];
let path = spline(pts);
let loop_wire = circle([-1.2, 0, z0], path.tangent_at(0.0), wire_diameter / 2.0).to_face().sweep(wire([path]));
fuse_all([handle, loop_wire])
