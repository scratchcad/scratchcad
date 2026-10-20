// Drink coaster: 100 mm, 6 mm tall, 3 mm recessed center 90 mm with concentric grooves and 4 felt-pad recesses
let diameter = 100.0; // [80.0, 120.0] Diameter (mm)
let height = 6.0; // [4.0, 10.0] Height (mm)
let c = cylinder(diameter / 2.0, height);
let cc = c.fillet(1.5, c.edges(">Z"));
let rec = cylinder([0, 0, height - 2.0], "Z", diameter / 2.0 - 5.0, 3.0);
let grooves = [];
for r in [10.0, 20.0, 30.0] { grooves.push(cylinder([0, 0, height - 3.0], "Z", r + 0.6, 2.0) - cylinder([0, 0, height - 4.0], "Z", r - 0.6, 4.0)); }
let pads = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; pads.push(cylinder([35.0 * a.cos(), 35.0 * a.sin(), -1], "Z", 5.0, 2.0)); }
cc - rec - compound(grooves) - compound(pads)
