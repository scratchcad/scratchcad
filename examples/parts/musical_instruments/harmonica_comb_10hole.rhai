// 10-hole diatonic harmonica comb: 101 x 27 x 5.6 mm, 10 chambers 4.5 mm wide on 7.2 mm pitch, 2 x 2.2 mm screw holes
let length = 101.0; // [90.0, 110.0] Length (mm)
let depth = 27.0; // [24.0, 30.0] Depth (mm)
let t = 5.6; // [4.5, 7.0] Thickness (mm)
let pitch = 7.2; // [6.5, 8.0] Hole pitch (mm)
let comb = box_centered(length, depth, t).translate([0, 0, t / 2.0]);
let chambers = [];
for i in 0..10 {
    let x = (i.to_float() - 4.5) * pitch;
    let ch = box_from_corners([x - 2.25, -depth / 2.0 - 1.0, -1], [x + 2.25, depth / 2.0 - 4.0, t + 1.0]);
    chambers.push(ch.fillet(1.5, ch.edges("|Z and >Y")));
}
comb - fuse_all(chambers) - cylinder([-length / 2.0 + 6.0, depth / 2.0 - 2.0, -1], "Z", 1.1, t + 2.0) - cylinder([length / 2.0 - 6.0, depth / 2.0 - 2.0, -1], "Z", 1.1, t + 2.0)
