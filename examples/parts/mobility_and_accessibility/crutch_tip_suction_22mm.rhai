// Forearm crutch suction tip: fits a 22 mm crutch tube, 55 mm tall, 52 mm bellows foot with a 3 mm deep suction dish, six radial tread ribs and a 4 mm steel cup insert recess
// # Fit
let tube = 22.0; // [18.0, 25.0] Crutch tube diameter (mm)
let socket_depth = 32.0; // [20.0, 40.0] Socket depth (mm)
// # Foot
let height = 55.0; // [45.0, 70.0] Tip height (mm)
let foot = 52.0; // [42.0, 62.0] Foot diameter (mm)
let ribs = 6; // [4, 12] Number of tread ribs
const wall = 4.0;
let r_top = tube / 2.0 + wall;
let body = sketch("XZ").move_to(0, 0).hline_to(foot / 2.0).vline(5.0).line_to(foot / 2.0 - 4.0, 9.0).line_to(r_top + 3.0, 16.0).line_to(r_top + 1.0, 22.0).line_to(r_top + 2.5, 26.0).line_to(r_top, height).hline_to(0).close().to_face().revolve("Z", 360);
let depth = min(socket_depth, height - 16.0);
let socket = cylinder([0, 0, height - depth], "Z", tube / 2.0, depth + 1.0);
let insert = cylinder([0, 0, height - depth - 4.0], "Z", tube / 2.0 - 2.0, 4.01);
let dish = cone(foot / 2.0 - 6.0, 4.0, 3.0).translate([0, 0, -0.01]);
let cuts = [];
for i in 0..ribs {
    cuts.push(box_centered(foot + 2.0, 2.0, 2.4).rotate_z(i.to_float() * 180.0 / ribs.to_float()));
}
let tread = fuse_all(cuts) - cylinder([0, 0, -3], "Z", 8.0, 6.0);
body - socket - insert - dish - tread
