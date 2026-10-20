// Chlorine floater lid: 170 mm dome lid 30 mm tall with 12 adjustable vent slots and a 35 mm grip knob
let diameter = 170.0; // [120.0, 220.0] Lid diameter (mm)
let height = 30.0; // [20.0, 45.0] Dome height (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let rs = (diameter * diameter / 4.0 + height * height) / (2.0 * height);
let dome = (sphere([0, 0, height - rs], rs) - sphere([0, 0, height - rs], rs - wall)) & cylinder(diameter / 2.0, height);
let skirt = cylinder(diameter / 2.0, 10.0) - cylinder([0, 0, -1], "Z", diameter / 2.0 - wall, 12.0);
let slots = [];
for k in 0..12 { slots.push(box_centered(30.0, 4.0, 20.0).translate([diameter * 0.3, 0, height * 0.5]).rotate_z(k.to_float() * 30.0)); }
let knob = cylinder([0, 0, height - 3.0], "Z", 17.5, 18.0);
(dome & cylinder(diameter / 2.0, height)) + skirt.translate([0, 0, -10.0 + 0.01]) - compound(slots) + knob
