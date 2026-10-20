// ATO blade fuse: 19.1 x 5.1 x 12.5 mm housing with grip ridge and test ports, two 6.3 x 0.64 mm blades
let blade_w = 6.3; // [5.0, 7.0] Blade width (mm)
let blade_len = 10.0; // [8.0, 12.0] Blade length (mm)
let housing = box_centered(19.1, 5.1, 12.5).translate([0, 0, 6.25]) + box_centered(19.1, 5.8, 2.0).translate([0, 0, 11.5]);
let fuse = housing - box_centered(12.0, 3.0, 2.0).translate([0, 0, 12.5]);
for x in [-6.6, 6.6] { fuse -= cylinder([x, 0, 9.0], "Z", 0.6, 5.0); }
let blades = [];
for x in [-4.65, 4.65] { blades.push(box_centered(blade_w, 0.64, blade_len).translate([x, 0, 1.5 - blade_len / 2.0])); }
fuse_all([fuse] + blades)
