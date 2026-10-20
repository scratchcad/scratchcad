// Urinal screen frame: 190 mm square mat 3 mm thick with 10 mm corner radii, a 4 mm raised rim 3 mm wide, an 8 x 8 grid of 12 mm square drain holes, and 64 short 3 mm round splash pins 4 mm tall between the holes
let size = 190.0; // [140.0, 220.0] Screen size (mm)
let grid = 8; // [4, 10] Number of holes along each side
let hole = 12.0; // [6.0, 16.0] Drain hole size (mm)
const t = 3.0;
const rim = 3.0;
let mat = box_centered(size, size, t).translate([0, 0, t / 2.0]);
let mat = mat.fillet(10.0, mat.edges("|Z"));
let rim_o = box_centered(size, size, 4.5).translate([0, 0, t + 1.75]);
let rim_o = rim_o.fillet(10.0, rim_o.edges("|Z"));
let rim_i = box_centered(size - 2.0 * rim, size - 2.0 * rim, 6.0).translate([0, 0, t + 3.0]);
let rim_i = rim_i.fillet(7.0, rim_i.edges("|Z"));
let n = grid.to_float();
let pitch = (size - 30.0) / n;
let hs = min(hole, pitch - 5.0);
let pins = [];
let cuts = [];
for i in 0..grid {
    for j in 0..grid {
        let x = -size / 2.0 + 15.0 + pitch * (i.to_float() + 0.5);
        let y = -size / 2.0 + 15.0 + pitch * (j.to_float() + 0.5);
        cuts.push(box_centered(hs, hs, t + 2.0).translate([x, y, t / 2.0]));
        pins.push(cylinder([x + pitch / 2.0, y + pitch / 2.0, t - 0.5], "Z", 1.5, 4.5));
    }
}
let body = (mat + (rim_o - rim_i)) - fuse_all(cuts);
body + fuse_all(pins)
