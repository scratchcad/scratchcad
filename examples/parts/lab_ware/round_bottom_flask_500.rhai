// 500 ml round-bottom flask: 105 mm sphere, 1.5 mm wall, 24/40 ground-glass joint neck tapering 24 to 20 mm over 40 mm
let d = 105.0; // [50.0, 200.0] Bulb diameter (mm)
let R = d / 2.0;
let neck_base = R * 0.95;
let outer = sphere(R) + cylinder([0, 0, neck_base - 5.0], "Z", 14.0, 30.0) + cone(14.0, 12.5, 40.0).translate([0, 0, neck_base + 25.0]);
let inner = sphere(R - 1.5) + cylinder([0, 0, neck_base - 10.0], "Z", 10.5, 80.0);
outer - inner
