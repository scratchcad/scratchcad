// Aeroponic cloner spray manifold tee for 1/2 inch PVC: socket tee 27.5 mm OD with three 21.5 mm sockets 18 mm deep (for 21.3 mm pipe), a 15.5 mm bore through, and a 10 mm boss on top with a 4 mm tapping hole for a 10-32 mister nozzle
let pipe_od = 21.3; // [16.0, 33.4] Pipe outside diameter (mm)
let socket_depth = 18.0; // [12.0, 30.0] Socket depth (mm)
let boss_h = 6.0; // [3.0, 12.0] Mister boss height (mm)
const wall = 3.0;
let rs = pipe_od / 2.0 + 0.1;
let ro = rs + wall;
let half = socket_depth + ro + 2.0;
let run = cylinder([-half, 0, 0], "X", ro, 2.0 * half);
let branch = cylinder([0, 0, 0], "Y", ro, half).rotate_z(180.0);
let boss = cylinder([0, 0, ro - 1.0], "Z", 5.0, boss_h + 1.0);
let body = fuse_all([run, branch, boss]);
let br = rs - 3.0;
let cuts = [
    cylinder([-half - 1.0, 0, 0], "X", rs, socket_depth + 1.0),
    cylinder([half - socket_depth, 0, 0], "X", rs, socket_depth + 1.0),
    cylinder([0, half - socket_depth, 0], "Y", rs, socket_depth + 1.0).rotate_z(180.0),
    cylinder([-half, 0, 0], "X", br, 2.0 * half),
    cylinder([0, 0, 0], "Y", br, half).rotate_z(180.0),
    cylinder([0, 0, 0], "Z", 2.0, ro + boss_h + 1.0)
];
body - fuse_all(cuts)
