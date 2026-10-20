// Faceted depression-glass style knob: 35 mm 12-facet crown 22 mm tall, 18 mm neck, M4 base insert hole
let d = 35.0; // [25.0, 45.0] Crown diameter (mm)
let height = 22.0; // [15.0, 30.0] Crown height (mm)
let neck = 18.0; // [12.0, 25.0] Neck diameter (mm)
let pts = [];
for i in 0..12 { let a = (i.to_float() * 30.0) * PI() / 180.0; pts.push([d / 2.0 * a.cos(), d / 2.0 * a.sin()]); }
let crown = polygon(pts).to_face().extrude([0, 0, height]).translate([0, 0, 10.0]);
let c = crown & cone(d * 0.75, d / 2.0 - 3.0, height).translate([0, 0, 10.0]) & sphere([0, 0, 10.0], d * 0.85);
let n = cone(neck / 2.0, neck / 2.0 + 2.0, 10.01);
c + n - cylinder([0, 0, -1], "Z", 1.7, 12.0)
