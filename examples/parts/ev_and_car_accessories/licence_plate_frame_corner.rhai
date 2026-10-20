// Licence plate frame corner: L-shaped slip-on corner for a 3 mm acrylic plate, 45 mm legs 12 mm wide, 3.2 mm slot 8 mm deep, 10 mm outer radius, 4.5 mm screw hole
let leg = 45.0; // [30.0, 70.0] Leg length (mm)
let arm = 12.0; // [10.0, 18.0] Leg width (mm)
let plate_t = 3.2; // [1.2, 4.0] Plate slot (mm)
let lip = 2.0; // [1.5, 3.0] Front and back lip thickness (mm)
let corner_r = 10.0; // [4.0, 14.0] Outer corner radius (mm)

const side = 3.0;
let total = 2.0 * lip + plate_t;
let l_shape = polygon([[0, 0, 0], [leg, 0, 0], [leg, arm, 0], [arm, arm, 0], [arm, leg, 0], [0, leg, 0]]);
let body = l_shape.to_face().extrude([0, 0, total]);
body = body.fillet(corner_r, body.edges("|Z").filter(|e| e.center().x.abs() < 0.01 && e.center().y.abs() < 0.01));
body = body.fillet(min(arm / 2.0 - 1.0, 3.0), body.edges("|Z").filter(|e| e.center().x > arm - 0.01 && e.center().y > arm - 0.01 && e.center().x < arm + 0.01));
// slot for the plate, entered from the inner edges, with a 3 mm side wall around the corner
body = body - box_from_corners([side, side, lip], [leg + 1.0, leg + 1.0, lip + plate_t]);
body = body.chamfer(0.6, body.edges(">Z"));
let hx = side + (arm - side) / 2.0 + 0.5;
body - cylinder([hx, hx, -1.0], "Z", 2.25, total + 2.0) - cone(2.25, 4.5, 2.3).translate([hx, hx, total - 2.25])
