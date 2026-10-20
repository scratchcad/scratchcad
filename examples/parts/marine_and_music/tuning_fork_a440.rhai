// A440 tuning fork: 6 x 6 mm steel tines 95 mm long, 12 mm gap, U-bend, 8 mm stem 40 mm long with a ball end
let tine = 95.0; // [60.0, 130.0] Tine length (mm)
let gap = 12.0; // [8.0, 16.0] Gap between tines (mm)
let prof = polygon([[-3, -3, 0], [3, -3, 0], [3, 3, 0], [-3, 3, 0]]);
let u = (torus(gap / 2.0 + 3.0, 3.0).rotate_x(90.0) & box_centered(40.0, 10.0, 20.0).translate([0, 0, -10.0]));
let tines = [box_centered(6.0, 6.0, tine).translate([-gap / 2.0 - 3.0, 0, tine / 2.0]), box_centered(6.0, 6.0, tine).translate([gap / 2.0 + 3.0, 0, tine / 2.0])];
let stem = cylinder([0, 0, -gap / 2.0 - 45.0], "Z", 4.0, 40.0) + sphere([0, 0, -gap / 2.0 - 45.0], 5.0);
fuse_all([u, stem] + tines)
