// Insulin vial protector sleeve for 10 ml vials (24.5 mm diameter, 45 mm tall): tube with a 25.2 mm bore and 2.5 mm wall 42 mm tall, a 2 mm base with a 14 mm hole, and 3 vertical 8 mm wide label windows 26 mm long with round ends
let vial_d = 24.5; // [20.0, 32.0] Vial diameter (mm)
let sleeve_h = 42.0; // [32.0, 55.0] Sleeve height (mm)
let wall = 2.5; // [1.8, 4.0] Wall thickness (mm)
let window_w = 8.0; // [5.0, 10.0] Window width (mm)
let windows = 3; // [2, 4] Number of windows
const base_t = 2.0;
const base_hole = 14.0;
let ri = vial_d / 2.0 + 0.35;
let ro = ri + wall;
let wl = sleeve_h - base_t - 14.0;
let z0 = base_t + 6.0;
let sleeve = cylinder(ro, sleeve_h) - cylinder([0, 0, base_t], "Z", ri, sleeve_h) - cylinder([0, 0, -1.0], "Z", min(base_hole, vial_d - 6.0) / 2.0, base_t + 2.0);
let wr = window_w / 2.0;
let cutters = [];
for i in 0..windows {
    let slot = fuse_all([
        box_from_corners([0, -wr, z0 + wr], [ro + 2.0, wr, z0 + wl - wr]),
        cylinder([0, 0, z0 + wr], "X", wr, ro + 2.0),
        cylinder([0, 0, z0 + wl - wr], "X", wr, ro + 2.0),
    ]);
    cutters.push(slot.rotate_z(30.0 + i * 360.0 / windows));
}
sleeve - fuse_all(cutters)
