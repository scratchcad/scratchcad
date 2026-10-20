// SBS/ANSI microplate deck nest for 96-well plates: 128.26 x 85.98 mm pocket (127.76 x 85.48 footprint + 0.5 mm), 6 mm deep, 3 mm walls, 2 mm floor with a 110 x 70 mm window, 3 mm corner reliefs, A1 notch marker
let clearance = 0.5; // [0.2, 1.5] Plate clearance (mm)
let depth = 6.0; // [3.0, 12.0] Pocket depth (mm)
let wall = 3.0; // [2.5, 6.0] Wall thickness (mm)
let floor_t = 2.0; // [1.5, 5.0] Floor thickness (mm)
let window = 0.85; // [0.0, 0.9] Floor window size relative to the plate
const sbs_l = 127.76;
const sbs_w = 85.48;
let pl = sbs_l + clearance;
let pw = sbs_w + clearance;
let ol = pl + 2.0 * wall;
let ow = pw + 2.0 * wall;
let nest = box_centered(ol, ow, floor_t + depth).translate([0, 0, (floor_t + depth) / 2.0]);
nest = nest.fillet(3.0, "|Z").chamfer(0.8, ">Z");
nest = nest - box_centered(pl, pw, depth + 1.0).translate([0, 0, floor_t + (depth + 1.0) / 2.0]);
let reliefs = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        reliefs.push(cylinder([sx * pl / 2.0, sy * pw / 2.0, floor_t], "Z", 1.5, depth + 1.0));
    }
}
nest = nest - compound(reliefs);
if window > 0.05 {
    let win = box_centered(sbs_l * window, sbs_w * window, floor_t + 2.0).translate([0, 0, floor_t / 2.0]);
    nest = nest - win.fillet(4.0, "|Z");
}
// A1 corner marker: a small chamfer notch in the top rim at the back left
nest - box_centered(6.0, 6.0, 4.0).rotate_z(45.0).translate([-ol / 2.0, ow / 2.0, floor_t + depth])
