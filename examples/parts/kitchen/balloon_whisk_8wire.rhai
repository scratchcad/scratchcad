// Balloon whisk: eight 1.8 mm stainless wires in four loops, 65 mm balloon 170 mm long, 25 mm handle 115 mm long with a hanging ring
let balloon_length = 170.0; // [100.0, 250.0] Balloon length (mm)
let balloon_diameter = 65.0; // [40.0, 100.0] Balloon diameter (mm)
let wire_diameter = 1.8; // [1.2, 3.0] Wire diameter (mm)
let loop_count = 4; // [2, 6] Number of wire loops
let handle_length = 115.0; // [80.0, 160.0] Handle length (mm)
let rb = balloon_diameter / 2.0;
let l = balloon_length;
// one loop in the XZ plane: down one side, round the tip, back up the other
let pts = [[7.0, 0, 5.0], [9.0, 0, -15.0], [rb * 0.75, 0, -l * 0.45], [rb, 0, -l * 0.75], [rb * 0.6, 0, -l * 0.97], [0, 0, -l],
           [-rb * 0.6, 0, -l * 0.97], [-rb, 0, -l * 0.75], [-rb * 0.75, 0, -l * 0.45], [-9.0, 0, -15.0], [-7.0, 0, 5.0]];
let path = spline(pts);
let profile = circle(path.start_point(), path.tangent_at(0.0), wire_diameter / 2.0);
let one = face(profile).sweep(path);
let wires = [];
for i in 0..loop_count {
    // stagger the loops by 0.2 mm in height so they do not all cross at a single point
    wires.push(one.translate([0, 0, 0.6 * i.to_float()]).rotate_z(i.to_float() * 180.0 / loop_count.to_float()));
}
let handle = sketch("XZ").move_to(0, 0).hline_to(10.0).line_to(12.5, handle_length * 0.6).arc_to(13.0, handle_length - 6.0, 9.0, handle_length).hline_to(0).close().to_face().revolve("Z", 360);
let ring = torus(8.0, 1.5).rotate_x(90.0).translate([0, 0, handle_length + 7.0]);
fuse_all([handle, ring] + wires)
