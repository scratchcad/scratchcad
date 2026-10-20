// Bookbinding bone folder: 200 x 25 x 5 mm, one rounded and one pointed end, edges chamfered to 1 mm
let length = 200.0; // [120.0, 250.0] Length (mm)
let width = 25.0; // [15.0, 35.0] Width (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let body = polygon([[0, 0], [length - 30.0, 0], [length, width * 0.3], [length, width * 0.7], [length - 30.0, width], [0, width]]).to_face().extrude([0, 0, t]);
let b = body.fillet(width / 2.0 - 0.5, body.edges("|Z and <X"));
b.chamfer(1.0, b.edges("not |Z"))
