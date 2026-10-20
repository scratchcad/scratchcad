// Scrub brush block: 150 x 55 x 15 mm back, 4 x 12 tufts of 5 mm holes 10 mm deep at 11.5 x 11 mm pitch, rounded ends, side finger grooves
let length = 150.0; // [100.0, 220.0] Block length (mm)
let width = 55.0; // [40.0, 80.0] Block width (mm)
let t = 15.0; // [10.0, 25.0] Block thickness (mm)
let cols = 12; // [6, 18] Tufts along the length
let rows = 4; // [2, 6] Tuft rows
let tuft_d = 5.0; // [3.0, 7.0] Tuft hole diameter (mm)
let blk = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let b1 = blk.fillet(width * 0.35, blk.edges("|Z"));
let b2 = b1.fillet(3.0, b1.edges(">Z"));
let px = (length - 25.0) / (cols - 1).to_float();
let py = (width - 20.0) / (rows - 1).to_float();
let holes = [];
for i in 0..cols { for j in 0..rows {
    holes.push(cylinder([-(length - 25.0) / 2.0 + i.to_float() * px, -(width - 20.0) / 2.0 + j.to_float() * py, -1], "Z", tuft_d / 2.0, 11.0));
} }
let grooves = cylinder([-length * 0.3, -width / 2.0 - 1.0, t * 0.7], "X", 3.5, length * 0.6) + cylinder([-length * 0.3, width / 2.0 + 1.0, t * 0.7], "X", 3.5, length * 0.6);
b2 - compound(holes) - grooves
