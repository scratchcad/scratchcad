// Small reaction wheel rotor: 34 mm, 10 mm thick rim, 2 mm web, 6 x 4 mm lightening holes, 5 mm hub bore 8 mm long
let diameter = 34.0; // [20.0, 60.0] Rotor diameter (mm)
let rim = 10.0; // [6.0, 15.0] Rim height (mm)
let rim_w = 4.0; // [2.0, 8.0] Rim width (mm)
let web = 2.0; // [1.0, 4.0] Web thickness (mm)
let r = cylinder(diameter / 2.0, rim) - cylinder([0, 0, web], "Z", diameter / 2.0 - rim_w, rim);
let hub = cylinder(5.0, 8.0);
let holes = [];
for k in 0..6 { let a = (k.to_float() * 60.0) * PI() / 180.0; holes.push(cylinder([(diameter / 4.0 + 1.5) * a.cos(), (diameter / 4.0 + 1.5) * a.sin(), -1], "Z", 2.0, web + 2.0)); }
r + hub - compound(holes) - cylinder([0, 0, -1], "Z", 2.5, 10.0)
