// Pipe lagging end cap for 15 mm pipe in 13 mm wall foam: 42 mm cup 23 mm long, 1.5 mm wall, 39 mm foam socket 20 mm deep, 15.5 mm pipe hole with 4 grip fingers
let pipe = 15.0; // [10.0, 28.0] Pipe size (mm)
let lagging_wall = 13.0; // [9.0, 25.0] Lagging wall thickness (mm)
let socket_depth = 20.0; // [10.0, 35.0] Socket depth (mm)
let wall = 1.5; // [1.0, 3.0] Cap wall (mm)
let fingers = 4; // [0, 8] Number of grip fingers
let rf = pipe / 2.0 + lagging_wall - 1.0;
let ro = rf + wall;
const end_t = 3.0;
let total = socket_depth + end_t;
let cap = cylinder(ro, total);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let body = cap - cylinder([0, 0, -1], "Z", rf, socket_depth + 1.0);
let rp = pipe / 2.0 + 0.25;
let shapes = [body];
for k in 0..fingers {
    let a = k.to_float() * 360.0 / fingers.to_float();
    shapes.push(box_from_corners([rp - 0.6, -1.5, socket_depth - 6.0], [rp + 1.5, 1.5, socket_depth + 0.5]).rotate_z(a));
}
fuse_all(shapes) - cylinder([0, 0, -1], "Z", rp, total + 2.0)
