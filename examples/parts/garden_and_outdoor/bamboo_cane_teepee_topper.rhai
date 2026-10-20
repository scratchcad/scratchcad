// Bamboo cane teepee topper: 44 mm hub with three 45 mm sockets for 12 mm canes splayed 20 degrees from vertical, hanging eye on top
let cane_diameter = 12.0; // [6.0, 20.0] Cane diameter (mm)
let socket_length = 45.0; // [25.0, 70.0] Socket length (mm)
let splay = 20.0; // [5.0, 40.0] Splay angle from vertical (degrees)
let canes = 3; // [3, 6] Number of canes
let wall = 2.5; // [1.5, 4.0] Socket wall (mm)
let rc = cane_diameter / 2.0 + 0.3;
let ro = rc + wall;
let hub = sphere(ro + 8.0);
let parts = [hub, torus(7.0, 2.0).rotate_x(90.0).translate([0, 0, ro + 13.0])];
let bores = [];
let s = (splay * PI() / 180.0).sin();
let c = (splay * PI() / 180.0).cos();
for i in 0..canes {
    let a = i.to_float() * 2.0 * PI() / canes.to_float();
    let d = [s * a.cos(), s * a.sin(), -c];
    parts.push(cylinder([0, 0, 0], d, ro, socket_length));
    bores.push(cylinder([d[0] * 10.0, d[1] * 10.0, d[2] * 10.0], d, rc, socket_length));
}
fuse_all(parts) - fuse_all(bores)
