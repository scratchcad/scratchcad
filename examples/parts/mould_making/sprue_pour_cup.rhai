// Resin casting sprue cup: 40 mm funnel cup 25 mm tall with 2 mm walls tapering to a 6 mm sprue 20 mm long, on a 30 mm locating flange 2 mm
let cup = 40.0; // [25.0, 60.0] Cup top diameter (mm)
let sprue = 6.0; // [3.0, 10.0] Sprue diameter (mm)
const wall = 2.0;
let outer = cone(sprue / 2.0 + wall, cup / 2.0, 25.0).translate([0, 0, 20.0]) + cylinder([0, 0, 0], "Z", sprue / 2.0 + wall, 20.01) + cylinder([0, 0, 0], "Z", 15.0, 2.0);
let inner = cone(sprue / 2.0, cup / 2.0 - wall, 25.02).translate([0, 0, 19.99]) + cylinder([0, 0, -1.0], "Z", sprue / 2.0, 22.0);
outer - inner
