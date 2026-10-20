// Kettle spout limescale filter: 40 x 30 mm frame 1.5 mm, mesh of 1 mm holes on 1.8 mm pitch, slide-in rails
let width = 40.0; // [25.0, 60.0] Width (mm)
let height = 30.0; // [20.0, 45.0] Height (mm)
let t = 1.5; // [1.0, 2.5] Thickness (mm)
let frame = box_centered(width, height, t).translate([0, 0, t / 2.0]);
let holes = [];
let nx = ((width - 6.0) / 1.8).floor().to_int();
let ny = ((height - 6.0) / 1.8).floor().to_int();
for i in 0..nx { for j in 0..ny { holes.push(cylinder([-width / 2.0 + 3.0 + 0.9 + i.to_float() * 1.8, -height / 2.0 + 3.0 + 0.9 + j.to_float() * 1.8, -1], "Z", 0.5, t + 2.0)); } }
let rails = box_from_corners([-width / 2.0, -height / 2.0, t - 0.01], [-width / 2.0 + 2.0, height / 2.0, t + 1.5]) + box_from_corners([width / 2.0 - 2.0, -height / 2.0, t - 0.01], [width / 2.0, height / 2.0, t + 1.5]);
frame - compound(holes) + rails
