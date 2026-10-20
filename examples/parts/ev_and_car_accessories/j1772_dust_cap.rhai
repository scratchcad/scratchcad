// SAE J1772 plug dust cap: 47 mm bore x 24 mm deep cup, 2 mm wall, 11 mm slot for the latch hook, 16 grip ribs, tether tab with 5 mm hole
let bore = 47.0; // [44.0, 52.0] Plug nose diameter (mm)
let depth = 24.0; // [15.0, 35.0] Cap depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let latch = 11.0; // [8.0, 14.0] Latch slot width (mm)
let ribs = 16; // [8, 24] Number of grip ribs

const end_t = 2.5;
let r_out = bore / 2.0 + wall;
let h = depth + end_t;
let cup = cylinder(r_out, h);
let grips = [];
for i in 0..ribs {
    grips.push(box_centered(2.0, 2.0, h - 4.0).translate([r_out + 0.5, 0, h / 2.0]).rotate_z(i * 360.0 / ribs + 360.0 / ribs / 2.0));
}
let tab = box_from_corners([-6.0, -r_out - 12.0, h - 2.5], [6.0, 0, h]);
tab = tab.fillet(5.5, tab.edges("|Z and <Y"));
let body = fuse_all([cup, fuse_all(grips), tab]);
body = body.chamfer(0.8, body.edges("<Z"));
body = body - cylinder([0, 0, end_t], "Z", bore / 2.0, h);
body = body - box_from_corners([-latch / 2.0, 0, h - 9.0], [latch / 2.0, r_out + 5.0, h + 1.0]);
body - cylinder([0, -r_out - 6.0, h - 4.0], "Z", 2.5, 6.0)
