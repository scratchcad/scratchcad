// Tiered cake dowel cap: fits 6.4 mm (1/4 in) dowels, 25 mm support disc 2 mm, 12 mm socket
let dowel = 6.4; // [5.0, 12.0] Dowel diameter (mm)
let disc = 25.0; // [15.0, 40.0] Support disc (mm)
let socket_l = 12.0; // [8.0, 20.0] Socket depth (mm)
let c = cylinder(disc / 2.0, 2.0) + cylinder([0, 0, -socket_l], "Z", dowel / 2.0 + 1.2, socket_l + 0.01);
c - cylinder([0, 0, -socket_l - 1.0], "Z", dowel / 2.0 + 0.1, socket_l)
