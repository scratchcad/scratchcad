// Fin key (3/32 in hex) with a T handle: 2.4 mm hex 25 mm, 30 x 10 x 5 mm grip with a lanyard hole
let hex = 2.38; // [2.0, 4.0] Hex size (mm)
let length = 25.0; // [15.0, 40.0] Hex length (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let shaft = polygon(pts).to_face().extrude([0, 0, length]);
let grip = box_centered(30.0, 10.0, 5.0).translate([0, 0, length + 2.49]);
let g = grip.fillet(4.5, grip.edges("|Z"));
shaft + g - cylinder([11.0, -10.0, length + 2.5], "Y", 1.5, 20.0)
