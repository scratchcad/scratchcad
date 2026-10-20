// Irrigation manifold: 4-way header for 16 mm drip lines on a 3/4 in BSP tap, 30 mm square bar 110 mm long, 26.4 mm tapped-boss bore 18 mm deep, four 16 mm barbed outlets at 25 mm pitch
// # Header
let outlets = 4; // [2, 6] Number of outlets
let pitch = 25.0; // [20.0, 35.0] Outlet pitch (mm)
let bar = 30.0; // [24.0, 40.0] Header bar size (mm)
// # Ports
let inlet_bore = 26.4; // [20.0, 33.0] Inlet thread bore (mm)
let pipe_id = 13.6; // [11.0, 17.0] Drip pipe inside diameter (mm)
let L = outlets.to_float() * pitch + 10.0;
let header = box_from_corners([0, -bar / 2.0, -bar / 2.0], [L, bar / 2.0, bar / 2.0]).fillet(3.0, "|X");
let boss = cylinder([-18.0, 0, 0], "X", inlet_bore / 2.0 + 4.0, 18.01);
let inlet = cylinder([-19.0, 0, 0], "X", inlet_bore / 2.0, 18.0);
let gallery = cylinder([-1.5, 0, 0], "X", 6.0, L - 4.0);
let rs = pipe_id / 2.0 - 0.6;
let spigots = [];
let bores = [];
for i in 0..outlets {
    let x = 10.0 + i.to_float() * pitch;
    spigots.push(cylinder([x, 0, bar / 2.0 - 0.5], "Z", rs, 22.5));
    spigots.push(cone(pipe_id / 2.0 + 1.0, rs - 0.3, 6.0).translate([x, 0, bar / 2.0 + 8.0]));
    spigots.push(cone(pipe_id / 2.0 + 1.0, rs - 0.3, 6.0).translate([x, 0, bar / 2.0 + 15.0]));
    bores.push(cylinder([x, 0, -1.0], "Z", rs - 1.5, bar / 2.0 + 25.0));
}
(header + boss + fuse_all(spigots)) - inlet - gallery - fuse_all(bores)
