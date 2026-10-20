// 45 degree set square, 200 mm legs, 3 mm thick, 70 mm inner cut-out and bevelled edges
let leg = 200.0; // [100.0, 300.0] Leg length (mm)
let thickness = 3.0; // [2.0, 4.0] Thickness (mm)
let border = 30.0; // [20.0, 50.0] Border width (mm)
let outer = polygon([[0, 0], [leg, 0], [0, leg]]).to_face().extrude([0, 0, thickness]);
let off = border * (1.0 + 2.0.sqrt());
let inner = polygon([[border, border], [leg - off, border], [border, leg - off]]).to_face().extrude([0, 0, thickness + 2.0]).translate([0, 0, -1.0]);
let i = inner.fillet(5.0, inner.edges("|Z"));
let s = outer - i;
s.chamfer(0.8, s.edges("<Z"))
