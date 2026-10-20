// Pottery kidney rib: 100 x 60 mm kidney shape 3 mm thick with a 1 mm bevelled working edge
let length = 100.0; // [70.0, 130.0] Rib length (mm)
let width = 60.0; // [40.0, 80.0] Rib width (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let pts = [];
for i in 0..24 { let a = (i.to_float() * 15.0) * PI() / 180.0; let dent = if a.sin() > 0.0 { 1.0 - 0.35 * a.sin() * a.sin() } else { 1.0 }; pts.push([length / 2.0 * a.cos(), width / 2.0 * a.sin() * dent]); }
let rib = polygon(pts).to_face().extrude([0, 0, t]);
rib.chamfer(1.0, rib.edges(">Z"))
