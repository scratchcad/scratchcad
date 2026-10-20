// Walking cane ferrule: rubber tip for a 19 mm (3/4 in) cane shaft, 40 mm tall, 44 mm tread with five 1 mm concentric grip grooves, 25 mm socket and a 2 mm steel-washer recess in its floor
// # Fit
let shaft = 19.0; // [16.0, 25.0] Cane shaft diameter (mm)
let socket_depth = 25.0; // [15.0, 30.0] Socket depth (mm)
// # Body
let height = 40.0; // [32.0, 55.0] Ferrule height (mm)
let tread = 44.0; // [38.0, 55.0] Tread diameter (mm)
let grooves = 5; // [2, 7] Number of grip grooves
const wall = 3.5;
let top_r = shaft / 2.0 + wall;
let depth = min(socket_depth, height - 10.0);
let body = sketch("XZ").move_to(0, 0).hline_to(tread / 2.0).vline(6.0).line_to(top_r + 2.0, 16.0).line_to(top_r, height).hline_to(0).close().to_face().revolve("Z", 360);
let socket = cylinder([0, 0, height - depth], "Z", shaft / 2.0, depth + 1.0);
let washer = cylinder([0, 0, height - depth - 2.0], "Z", shaft / 2.0 - 1.0, 2.01);
let step = (tread / 2.0 - 6.0) / grooves.to_float();
let rings = [];
for i in 0..grooves {
    let r = 5.0 + i.to_float() * step;
    rings.push(cylinder([0, 0, -1], "Z", r + 0.5, 2.0) - cylinder([0, 0, -2], "Z", r - 0.5, 4.0));
}
body - socket - washer - fuse_all(rings)
