// Ring sizer gauge strip: US sizes 4 to 9 holes (14.9 to 18.9 mm), 140 x 28 x 2 mm with a hang hole
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let sizes = [14.9, 15.7, 16.5, 17.3, 18.1, 18.9];
let length = 140.0; // [120.0, 180.0] Strip length (mm)
let strip = box_from_corners([0, 0, 0], [length, 28.0, t]);
let s = strip.fillet(5.0, strip.edges("|Z"));
let holes = [];
for i in 0..sizes.len() { holes.push(cylinder([12.0 + i.to_float() * 21.0, 14.0, -1], "Z", sizes[i] / 2.0, t + 2.0)); }
s - compound(holes) - cylinder([length - 6.0, 14.0, -1], "Z", 2.5, t + 2.0)
