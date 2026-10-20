// Door lever rose: 52 mm rose 10 mm tall with a 22 mm boss with a 16 mm x 3 mm recess for the lever neck, an 8 mm square spindle hole through, and three 3.5 mm fixing holes on a 38 mm PCD
let dia = 52.0; // [45.0, 60.0] Rose diameter (mm)
let height = 10.0; // [6.0, 15.0] Rose height (mm)
const spindle = 8.0;
let rose = cylinder([0, 0, 0], "Z", dia / 2.0, height) + cone(dia / 2.0, 12.0, 4.0).translate([0, 0, height - 0.01]);
let neck = cylinder([0, 0, height + 1.0], "Z", 8.0, 4.0);
let sq = box_centered(spindle + 0.4, spindle + 0.4, 2.0 * height + 10.0);
let holes = [];
for i in 0..3 { let a = (90.0 + 120.0 * i.to_float()) * PI() / 180.0; holes.push(cylinder([19.0 * cos(a), 19.0 * sin(a), -1.0], "Z", 1.75, height + 2.0)); }
rose - neck - sq - fuse_all(holes)
