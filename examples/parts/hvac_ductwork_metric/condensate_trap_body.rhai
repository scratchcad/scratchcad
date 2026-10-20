// HVAC condensate trap body: 55 mm OD x 110 mm closed canister 2.5 mm wall, 20 mm inlet spigot on top feeding a dip tube to 25 mm above the floor, 25 mm outlet spigot on the side 45 mm below the top, 6 mm cleaning drain boss
let body_d = 55.0; // [50.0, 80.0] Body diameter (mm)
let height = 110.0; // [90.0, 160.0] Body height (mm)
let inlet_d = 20.0; // [16.0, 22.0] Inlet spigot diameter (mm)
let outlet_d = 25.0; // [20.0, 28.0] Outlet spigot diameter (mm)
let seal = 45.0; // [35.0, 60.0] Outlet depth below the top (mm)
let wall = 2.5; // [2.0, 3.0] Wall thickness (mm)
const spigot_l = 25.0;
let rb = body_d / 2.0;
let ri = inlet_d / 2.0;
let ro = outlet_d / 2.0;
let can = cylinder(rb, height) - cylinder([0, 0, wall], "Z", rb - wall, height - 2.0 * wall);
let dip = cylinder([0, 0, 25.0], "Z", ri, height + spigot_l - 25.0);
let z_out = height - seal;
let x0 = ri + 1.5;
let outlet = cylinder([x0, 0, z_out], "X", ro, rb + spigot_l - x0);
let boss = cylinder([0, 0, -6.0], "Z", 7.0, 6.5);
let body = fuse_all([can, dip, outlet, boss]);
let bores = fuse_all([
    cylinder([0, 0, 24.0], "Z", ri - 2.0, height + spigot_l),
    cylinder([x0 + 1.0, 0, z_out], "X", ro - 2.0, rb + spigot_l),
    cylinder([0, 0, -7.0], "Z", 3.0, 7.0 + wall + 1.0)]);
body - bores
