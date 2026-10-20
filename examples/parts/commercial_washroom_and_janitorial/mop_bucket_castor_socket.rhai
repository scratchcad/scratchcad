// Mop bucket castor socket: 22 mm round socket 30 mm long with a 10.2 mm bore 25 mm deep for a 10 mm castor stem, a 0.8 mm snap groove for the stem ring 8 mm in, a 30 mm flange 3 mm thick at the open end and four 1.5 mm crush ribs down the outside for the bucket boss
let stem_d = 10.0; // [8.0, 12.0] Castor stem diameter (mm)
let socket_len = 30.0; // [20.0, 45.0] Socket length (mm)
let socket_d = 22.0; // [16.0, 30.0] Socket outside diameter (mm)
let ribs = 4; // [3, 8] Number of crush ribs
const ft = 3.0;
let rb = stem_d / 2.0 + 0.1;
let ro = max(socket_d / 2.0, rb + 3.0);
let rf = ro + 4.0;
let bd = socket_len - 5.0;
let pts = [[0, 0, socket_len], [ro, 0, socket_len], [ro, 0, ft], [rf, 0, ft], [rf, 0, 0], [rb, 0, 0], [rb, 0, 7.5], [rb + 0.8, 0, 7.5], [rb + 0.8, 0, 8.5], [rb, 0, 8.5], [rb, 0, bd], [0, 0, bd]];
let socket = face(polygon(pts)).revolve("Z", 360.0);
let parts = [socket];
for i in 0..ribs {
    parts.push(box_from_corners([ro - 0.5, -0.75, ft + 2.0], [ro + 1.5, 0.75, socket_len - 2.0]).rotate_z(i.to_float() * 360.0 / ribs.to_float()));
}
fuse_all(parts)
