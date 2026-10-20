// Pattern block trapezoid (half hexagon): 25.4 mm sides, 50.8 mm base, 10 mm thick
let side = 25.4; // [20.0, 40.0] Side length (mm)
let t = 10.0; // [5.0, 15.0] Thickness (mm)
let h = side * 3.0.sqrt() / 2.0;
let p = polygon([[0, 0], [2.0 * side, 0], [1.5 * side, h], [0.5 * side, h]]).to_face().extrude([0, 0, t]);
p.chamfer(0.8, p.edges("not |Z"))
