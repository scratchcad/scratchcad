// Press-fit arrow nock for 0.244 inch ID shafts: 6.2 mm shank 12 mm long, 7.5 mm body 11 mm long with a 2.5 mm string throat 6 mm deep and a rounded mouth
let shank_d = 6.2; // [5.0, 6.5] Shaft ID (mm)
let body_d = 7.5; // [6.5, 8.5] Nock body OD (mm)
let throat = 2.5; // [2.0, 3.2] String throat width (mm)
const body_l = 11.0;
let shank = cylinder([0, 0, -12.0], "Z", shank_d / 2.0, 12.01);
let collar = cylinder([0, 0, 0], "Z", body_d / 2.0, 1.0);
let body = cone(body_d / 2.0, body_d / 2.0 - 0.4, body_l).translate([0, 0, 0.99]);
let slot = box_from_corners([-throat / 2.0, -body_d, body_l - 5.0], [throat / 2.0, body_d, body_l + 3.0]);
let seat = cylinder([0, -body_d, body_l - 5.0], "Y", throat / 2.0, 2.0 * body_d);
let n = shank + collar + body - slot - seat;
n.chamfer(0.3, n.edges(">Z"))
