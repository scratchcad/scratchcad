// Laser level target card: 80 x 120 x 2 mm with a 5 mm grid of 0.5 mm grooves, 15 mm magnet pocket and center notch
let width = 80.0; // [50.0, 120.0] Width (mm)
let height = 120.0; // [80.0, 160.0] Height (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let plate = box_centered(width, height, t).translate([0, 0, t / 2.0]);
let grooves = [];
let nx = (width / 10.0).floor().to_int();
let ny = (height / 10.0).floor().to_int();
for i in 1..nx { grooves.push(box_centered(0.5, height - 10.0, 1.0).translate([-width / 2.0 + i.to_float() * 10.0, 0, t])); }
for j in 1..ny { grooves.push(box_centered(width - 10.0, 0.5, 1.0).translate([0, -height / 2.0 + j.to_float() * 10.0, t])); }
plate - fuse_all(grooves) - box_centered(6.0, 10.0, t * 3.0).translate([0, -height / 2.0, 0]) - cylinder([0, height / 2.0 - 15.0, -1], "Z", 7.5, 2.0)
