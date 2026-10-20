// Tube seed bird feeder: 70 mm tube 250 mm tall, 2 mm wall, four 22 mm feeding ports on two levels, 4 mm through perches, domed lid with hanging loop
let tube_diameter = 70.0; // [50.0, 100.0] Tube diameter (mm)
let tube_height = 250.0; // [150.0, 400.0] Tube height (mm)
let wall = 2.0; // [1.5, 4.0] Wall thickness (mm)
let port_diameter = 22.0; // [12.0, 30.0] Feeding port diameter (mm)
let perch_length = 110.0; // [80.0, 160.0] Perch length, end to end (mm)
let r = tube_diameter / 2.0;
let tube = cylinder(r, tube_height) - cylinder([0, 0, 3.0], "Z", r - wall, tube_height);
let base = cylinder([0, 0, -6.0], "Z", r + 10.0, 9.0) - cylinder([0, 0, 1.0], "Z", r + 8.0, 4.0);
let lid = sketch("XZ").move_to(0, tube_height - 1.0).hline_to(r + 6.0).vline(4.0).arc_to(r * 0.7, tube_height + 22.0, 0, tube_height + 30.0).close()
    .to_face().revolve("Z", 360);
let loop_ring = torus(12.0, 2.5).rotate_x(90.0).translate([0, 0, tube_height + 40.0]);
let parts = [tube, base, lid, loop_ring];
let cuts = [];
for level in 0..2 {
    let z = 45.0 + level.to_float() * (tube_height - 110.0);
    let a = level.to_float() * 90.0;
    parts.push(cylinder([0, -(r + 6.0), z], "Y", port_diameter / 2.0 + 4.0, 2.0 * r + 12.0).rotate_z(a) & cylinder([0, 0, z - 20.0], "Z", r + 6.0, 40.0));
    parts.push(cylinder([0, -perch_length / 2.0, z - 20.0], "Y", 2.0, perch_length).rotate_z(a));
    cuts.push(cylinder([0, -(r + 10.0), z], "Y", port_diameter / 2.0, 2.0 * r + 20.0).rotate_z(a));
}
fuse_all(parts) - fuse_all(cuts + [cylinder([0, 0, 3.0], "Z", r - wall, tube_height - 4.0)])
