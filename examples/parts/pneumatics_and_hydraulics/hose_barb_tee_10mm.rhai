// Hose barb tee for 10 mm ID hose: three barbs 22 mm long, 12.5 mm barb crest, 7 mm bore, 14 mm hub
let hose = 10.0; // [5.0, 20.0] Hose ID (mm)
let barb_l = 22.0; // [12.0, 35.0] Barb length (mm)
let bore = 7.0; // [3.0, 15.0] Bore (mm)
let one = cone(hose / 2.0 + 1.2, hose / 2.0 - 0.3, 7.0).translate([0, 0, 7.0]) + cone(hose / 2.0 + 1.2, hose / 2.0 - 0.3, 7.0).translate([0, 0, 14.0]) + cylinder([0, 0, 0], "Z", hose / 2.0 - 0.3, barb_l);
let hub = sphere(hose / 2.0 + 2.0);
let arms = one.rotate_y(90.0) + one.rotate_y(-90.0) + one;
let bores = cylinder([-barb_l - 1.0, 0, 0], "X", bore / 2.0, 2.0 * barb_l + 2.0) + cylinder([0, 0, 0], "Z", bore / 2.0, barb_l + 1.0);
hub + arms - bores
