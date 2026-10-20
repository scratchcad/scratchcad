// Push-and-turn cap wrench for 38 mm child-resistant pharmacy caps: 15 mm deep cup with a 38.6 mm bore, 4 mm wall and 3 mm top, 24 internal grip ribs 1 mm high, a palm boss 30 mm across on top, and two 45 mm lever handles 12 mm wide
let cap_d = 38.6; // [28.0, 50.0] Cap bore (mm)
let depth = 15.0; // [10.0, 20.0] Cup depth (mm)
let ribs = 24; // [12, 36] Number of grip ribs
let handle_len = 45.0; // [30.0, 70.0] Handle length (mm)
const wall = 4.0;
const top_t = 3.0;
const rib_h = 1.0;
const handle_w = 12.0;
let ri = cap_d / 2.0;
let ro = ri + wall;
let h = depth + top_t;
let cup = cylinder(ro, h) - cylinder([0, 0, -1.0], "Z", ri, depth + 1.0);
let parts = [cup, cylinder([0, 0, h - 0.5], "Z", 15.0, 6.0)];
for i in 0..ribs {
    parts.push(box_from_corners([ri - rib_h, -0.75, 0], [ri + 0.5, 0.75, depth + 0.5]).rotate_z((i + 0.5) * 360.0 / ribs));
}
let handle = box_from_corners([ro - 1.0, -handle_w / 2.0, h - 8.0], [ro + handle_len, handle_w / 2.0, h]);
let handle = handle.fillet(5.0, handle.edges("|Z and >X"));
parts.push(handle);
parts.push(handle.rotate_z(180.0));
fuse_all(parts)
