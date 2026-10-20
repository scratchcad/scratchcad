// Profile spot iris leaf: 0.8 mm crescent blade on a 34 mm arc radius sweeping 100 degrees, 8 mm wide with rounded ends, 2 mm pivot pin at one end and a 2 mm drive pin at the other
let radius = 34.0; // [20.0, 50.0] Arc radius (mm)
let sweep_deg = 100.0; // [60.0, 140.0] Arc sweep (degrees)
let width = 8.0; // [5.0, 12.0] Leaf width (mm)
let thickness = 0.8; // [0.5, 1.5] Leaf thickness (mm)
let a = sweep_deg * PI() / 180.0;
const n = 24;
let pts = [];
for i in 0..=n { let t = i.to_float() / n.to_float() * a; pts.push([(radius + width / 2.0) * t.cos(), (radius + width / 2.0) * t.sin()]); }
for i in 0..=n { let t = a - i.to_float() / n.to_float() * a; pts.push([(radius - width / 2.0) * t.cos(), (radius - width / 2.0) * t.sin()]); }
let leaf = polygon("XY", pts).to_face().extrude([0, 0, thickness]);
let ends = cylinder([radius, 0, 0], "Z", width / 2.0, thickness) + cylinder([radius * a.cos(), radius * a.sin(), 0], "Z", width / 2.0, thickness);
let pins = cylinder([radius, 0, thickness - 0.01], "Z", 1.0, 2.0) + cylinder([radius * a.cos(), radius * a.sin(), -1.99], "Z", 1.0, 2.0);
leaf + ends + pins
