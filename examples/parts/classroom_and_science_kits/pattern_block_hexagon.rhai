// Pattern block hexagon: 25.4 mm (1 in) sides, 10 mm thick, 0.8 mm edge chamfer
let side = 25.4; // [20.0, 40.0] Side length (mm)
let t = 10.0; // [5.0, 15.0] Thickness (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([side * a.cos(), side * a.sin()]); }
let h = polygon(pts).to_face().extrude([0, 0, t]);
h.chamfer(0.8, h.edges("not |Z"))
