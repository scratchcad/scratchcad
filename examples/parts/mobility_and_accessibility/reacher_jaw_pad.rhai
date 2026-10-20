// Reacher jaw pad: replacement gripper jaw for a 32 inch pick-up reacher, 70 x 28 mm pad 4 mm thick with a 1.2 mm cupped face and 8 grip ridges 1 mm proud, 30 mm mounting tang with two 4 mm rivet holes 12 mm apart and a 10 x 3 mm magnet pocket
// # Pad
let pad_length = 70.0; // [50.0, 90.0] Pad length (mm)
let pad_width = 28.0; // [20.0, 40.0] Pad width (mm)
let pad_t = 4.0; // [3.0, 6.0] Pad thickness (mm)
let ridges = 8; // [3, 14] Number of grip ridges
// # Tang
let tang_length = 30.0; // [20.0, 40.0] Mounting tang length (mm)
let rivet = 4.0; // [3.0, 5.0] Rivet hole diameter (mm)
const cup_depth = 1.2;
let rc = pad_width * 1.2;
let axis_z = pad_t + rc - cup_depth;
let pad = box_from_corners([0, -pad_width / 2.0, 0], [pad_length, pad_width / 2.0, pad_t]).fillet(pad_width / 2.0 - 1.0, "|Z and >X");
let cup = cylinder([-1.0, 0, axis_z], "X", rc, pad_length + 2.0);
let rs = [];
for i in 0..ridges {
    let x = 6.0 + i.to_float() * (pad_length - 20.0) / (ridges - 1).to_float();
    rs.push(box_from_corners([x - 0.75, -pad_width / 2.0 + 2.5, pad_t - 2.0], [x + 0.75, pad_width / 2.0 - 2.5, pad_t + 2.0]));
}
let ridge_set = fuse_all(rs) - cylinder([-1.0, 0, axis_z], "X", rc - 1.0, pad_length + 2.0);
let tang = box_from_corners([-tang_length, -6.0, 0], [0.5, 6.0, 3.0]);
let holes = [cylinder([-tang_length + 6.0, 0, -1], "Z", rivet / 2.0, 6.0), cylinder([-tang_length + 18.0, 0, -1], "Z", rivet / 2.0, 6.0)];
let magnet = cylinder([pad_length - 12.0, 0, -0.01], "Z", 5.1, 2.0);
(pad - cup) + ridge_set + tang - compound(holes) - magnet
