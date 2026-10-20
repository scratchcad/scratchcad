// Inhaler spacer port adapter: rounded-rectangle socket 26 x 19 mm inside and 14 mm deep with a 1.8 mm wall for a metered-dose inhaler mouthpiece, on a 3 mm bulkhead, over a 22 mm spigot 20 mm long, bored 17 mm through into the socket, that pushes into a spacer chamber, with a 1 mm lead-in chamfer on the spigot
let socket_w = 26.0; // [22.0, 32.0] Socket inside width (mm)
let socket_h = 19.0; // [16.0, 24.0] Socket inside height (mm)
let socket_depth = 14.0; // [8.0, 20.0] Socket depth (mm)
let spigot_d = 22.0; // [18.0, 30.0] Spigot outside diameter (mm)
let spigot_len = 20.0; // [12.0, 30.0] Spigot length (mm)
const wall = 1.8;
const bulkhead = 3.0;
const corner = 5.0;
let ow = max(socket_w + 2.0 * wall, spigot_d + 2.0);
let oh = max(socket_h + 2.0 * wall, spigot_d + 2.0);
let z0 = spigot_len;
let outer = box_centered(ow, oh, bulkhead + socket_depth).translate([0, 0, z0 + (bulkhead + socket_depth) / 2.0]);
let outer = outer.fillet(corner + wall, outer.edges("|Z"));
let inner = box_centered(socket_w, socket_h, socket_depth + 1.0).translate([0, 0, z0 + bulkhead + (socket_depth + 1.0) / 2.0]);
let inner = inner.fillet(corner, inner.edges("|Z"));
let spigot = cylinder([0, 0, 0], "Z", spigot_d / 2.0, z0 + 0.5);
let spigot = spigot.chamfer(1.0, spigot.edges("<Z"));
let body = (outer + spigot) - inner;
let port = min(spigot_d / 2.0 - wall, min(socket_w, socket_h) / 2.0 - 1.0);
body - cylinder([0, 0, -1.0], "Z", port, z0 + bulkhead + 2.0)
