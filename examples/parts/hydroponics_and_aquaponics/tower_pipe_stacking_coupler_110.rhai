// Vertical grow tower stacking coupler for 110 mm pipe: 3 mm sleeve with a 40 mm socket each end (110.6 mm bore), a 4 mm internal stop ring 3 mm wide in the middle, and four 2 mm outer grip ribs
let pipe_od = 110.0; // [75.0, 160.0] Pipe outside diameter (mm)
let socket_depth = 40.0; // [20.0, 60.0] Socket depth each end (mm)
let wall = 3.0; // [2.0, 5.0] Sleeve wall (mm)
const stop = 4.0;
const stop_w = 3.0;
let ri = pipe_od / 2.0 + 0.3;
let ro = ri + wall;
let h = 2.0 * socket_depth + stop_w;
let pts = [[ri, 0, 0], [ro, 0, 0], [ro, 0, h], [ri, 0, h], [ri, 0, socket_depth + stop_w], [ri - stop, 0, socket_depth + stop_w], [ri - stop, 0, socket_depth], [ri, 0, socket_depth]];
let sleeve = face(polygon(pts)).revolve("Z", 360.0);
let ribs = [];
for i in 0..4 {
    ribs.push(box_from_corners([ro - 1.0, -1.0, 4.0], [ro + 2.0, 1.0, h - 4.0]).rotate_z(i.to_float() * 90.0));
}
fuse_all([sleeve] + ribs)
