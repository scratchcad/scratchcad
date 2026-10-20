// Chisel edge guard for a 25 mm bevel-edge chisel: 25.6 x 5.4 mm pocket 35 mm deep in a 31.6 x 11.4 x 38 mm sleeve, grip ribs on both faces
let blade_w = 25.6; // [6.0, 40.0] Blade width with clearance (mm)
let blade_t = 5.4; // [3.0, 9.0] Blade thickness with clearance (mm)
let depth = 35.0; // [20.0, 50.0] Pocket depth (mm)
let wall = 3.0; // [1.5, 4.0] Wall thickness (mm)
let ow = blade_w + 2.0 * wall;
let ot = blade_t + 2.0 * wall;
let outer = box_from_corners([-ow / 2.0, -ot / 2.0, 0], [ow / 2.0, ot / 2.0, depth + wall]);
let o = outer.fillet(2.0, outer.edges("|Z"));
let pocket = box_from_corners([-blade_w / 2.0, -blade_t / 2.0, wall], [blade_w / 2.0, blade_t / 2.0, depth + wall + 1.0]);
let ribs = [];
for i in 0..4 { for s in [-1.0, 1.0] {
    ribs.push(box_from_corners([-ow / 2.0 + 3.0, s * ot / 2.0 - 0.5, 6.0 + i.to_float() * 7.0], [ow / 2.0 - 3.0, s * ot / 2.0 + 0.5, 8.0 + i.to_float() * 7.0]));
} }
o + fuse_all(ribs) - pocket
