// Licence plate screw snap cap: 18 mm dome 8 mm tall, hollow with a 12.5 mm socket that grips a 1/4 in screw retainer, 0.8 mm snap bead
let cap_d = 18.0; // [14.0, 24.0] Cap diameter (mm)
let cap_height = 8.0; // [6.0, 12.0] Cap height (mm)
let socket_d = 12.5; // [9.0, 16.0] Socket diameter (mm)
let socket_depth = 5.0; // [3.0, 8.0] Socket depth (mm)
let r = cap_d / 2.0;
let sd = min(socket_d, cap_d - 3.0);
let sh = min(socket_depth, cap_height - 1.5);
// spherical dome: centred on the axis, through the shoulder (r, 0.35 h) and the top (0, h)
let shoulder = cap_height * 0.35;
let zc = (r * r + shoulder * shoulder - cap_height * cap_height) / (2.0 * (shoulder - cap_height));
let dome_r = cap_height - zc;
let mx = r * 0.6;
let prof = sketch("XZ").move_to(0, 0).hline_to(r).vline_to(shoulder).arc_to(mx, zc + sqrt(dome_r * dome_r - mx * mx), 0, cap_height).close();
let cap = prof.to_face().revolve("Z", 360);
let socket = cylinder([0, 0, -1.0], "Z", sd / 2.0, sh + 1.0);
let bead = cylinder([0, 0, 0.8], "Z", sd / 2.0 + 0.01, 0.8) - cylinder([0, 0, 0.7], "Z", sd / 2.0 - 0.6, 1.0);
cap - socket + bead
