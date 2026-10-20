// Solvent-weld waste reducer 40 to 32 mm (BS EN 1329 ABS sizes): 42.8 mm spigot 22 mm long into a 40 mm socket, 36.4 mm socket 20 mm deep for 32 mm pipe, 46 mm shoulder 3 mm
let spigot_od = 42.8; // [36.5, 56.0] Spigot outside diameter (mm)
let spigot_len = 22.0; // [12.0, 35.0] Spigot length (mm)
let socket_id = 36.4; // [30.0, 50.0] Socket bore for smaller pipe (mm)
let socket_depth = 20.0; // [12.0, 30.0] Socket depth (mm)
let shoulder = 3.0; // [2.0, 6.0] Shoulder thickness (mm)
let rs = spigot_od / 2.0;
let rk = min(socket_id / 2.0, rs - 1.6);
let rb = rk - 2.4;
let rsh = rs + 1.6;
let total = spigot_len + shoulder;
let pts = [
    [rb, 0, 0], [rs - 0.8, 0, 0], [rs, 0, 0.8], [rs, 0, spigot_len], [rsh, 0, spigot_len],
    [rsh, 0, total], [rk, 0, total], [rk, 0, total - socket_depth], [rb, 0, total - socket_depth - 1.5]
];
polygon(pts).to_face().revolve("Z", 360)
