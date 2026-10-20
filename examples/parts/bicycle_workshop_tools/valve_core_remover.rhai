// Presta valve core remover: 10 mm round body 22 mm long with two 8 mm thumb flats, 5.4 mm socket 6 mm deep with a 1.6 mm cross slot for the core flats at one end, 3 mm lanyard hole at the other
let body_d = 10.0; // [8.0, 14.0] Body diameter (mm)
let length = 22.0; // [16.0, 35.0] Body length (mm)
let socket_d = 5.4; // [4.8, 6.0] Socket diameter (mm)
let slot_w = 1.6; // [1.2, 2.0] Slot width (mm)
const socket_depth = 6.0;
let body = cylinder(body_d / 2.0, length);
let body = body.chamfer(0.6, body.edges(">Z or <Z"));
let flat = body_d / 2.0 - 1.0;
let cuts = fuse_all([
    box_from_corners([flat, -body_d, socket_depth + 2.0], [body_d, body_d, length - 2.0]),
    box_from_corners([-body_d, -body_d, socket_depth + 2.0], [-flat, body_d, length - 2.0]),
    cylinder([0, 0, -1.0], "Z", socket_d / 2.0, socket_depth + 1.0),
    box_from_corners([-body_d, -slot_w / 2.0, -1.0], [body_d, slot_w / 2.0, socket_depth]),
    cylinder([0, -body_d, length - 4.0], "Y", 1.5, 2.0 * body_d),
]);
body - cuts
