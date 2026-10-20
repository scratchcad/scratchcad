// Overlocker needle inserter: 10 mm handle 60 mm long with six 8.7 mm wide flats, 1 mm chamfers, 2.1 mm D-shaped needle socket 15 mm deep (1.6 mm across the flat) in a 6 mm nose 10 mm long at one end
let handle_len = 60.0; // [40.0, 90.0] Handle length (mm)
let handle_d = 10.0; // [8.0, 14.0] Handle diameter (mm)
let socket_d = 2.1; // [1.8, 2.4] Needle shank socket (mm)
let socket_depth = 15.0; // [8.0, 20.0] Socket depth (mm)
const nose_d = 6.0;
const nose_len = 10.0;
let r = handle_d / 2.0;
let af = handle_d * 0.87;
let pts = [];
let rv = af / sqrt(3.0);
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    pts.push([rv * cos(a), rv * sin(a), 0.0]);
}
let handle = polygon(pts).to_face().extrude([0, 0, handle_len]) & cylinder(r, handle_len).chamfer(1.0, ">Z");
let nose = cylinder([0, 0, -nose_len], "Z", nose_d / 2.0, nose_len + 0.5);
let nose = nose.chamfer(0.8, nose.edges("<Z"));
let socket = cylinder([0, 0, -nose_len - 1.0], "Z", socket_d / 2.0, socket_depth + 1.0) - box_from_corners([socket_d / 2.0 - 0.5, -2.0, -nose_len - 2.0], [2.0, 2.0, socket_depth]);
(handle + nose) - socket
