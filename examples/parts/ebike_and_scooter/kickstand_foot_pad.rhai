// Kickstand foot enlarger pad: 70 x 50 mm oval 5 mm base with a 22 x 12 mm socket 15 mm tall for the stand foot
let length = 70.0; // [50.0, 100.0] Pad length (mm)
let width = 50.0; // [35.0, 70.0] Pad width (mm)
let socket_l = 22.0; // [15.0, 35.0] Socket length (mm)
let socket_w = 12.0; // [8.0, 20.0] Socket width (mm)
let pad = box_centered(length, width, 5.0).translate([0, 0, 2.5]);
let p = pad.fillet(width / 2.0 - 0.5, pad.edges("|Z"));
let socket = box_centered(socket_l + 6.0, socket_w + 6.0, 15.0).translate([0, 0, 12.49]);
let s = socket.fillet(3.0, socket.edges("|Z"));
p + s - box_centered(socket_l, socket_w, 16.0).translate([0, 0, 13.0])
