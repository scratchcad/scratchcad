// Outboard cooling tell-tale nozzle: snap-in fitting for a 10 mm cowling hole, 14 mm flange 2 mm thick, 6 mm barrel through the cowl with a 0.6 mm snap ridge, 3 mm bore, and a 6 mm hose barb 12 mm long behind for the 1/4 in tell-tale hose, with an angled 4 mm spout bent 30 degrees down in front
let hole_d = 10.0; // [8.0, 14.0] Cowling hole diameter (mm)
let cowl_t = 3.0; // [1.5, 5.0] Cowling thickness (mm)
let barb_len = 12.0; // [8.0, 20.0] Hose barb length (mm)
const bore = 3.0;
let rh = hole_d / 2.0 - 0.2;
let z0 = -cowl_t;
let profile = polygon([
    [bore / 2.0, 0, 2.0], [7.0, 0, 2.0], [7.0, 0, 0], [rh, 0, 0], [rh, 0, z0], [rh + 0.6, 0, z0 - 0.6], [rh, 0, z0 - 2.5],
    [3.0, 0, z0 - 2.5], [3.0, 0, z0 - 2.5 - barb_len * 0.4], [3.6, 0, z0 - 2.5 - barb_len * 0.4 - 0.5], [3.0, 0, z0 - 2.5 - barb_len * 0.7],
    [3.6, 0, z0 - 2.5 - barb_len * 0.7 - 0.5], [2.8, 0, z0 - 2.5 - barb_len], [bore / 2.0, 0, z0 - 2.5 - barb_len]]);
let body = face(profile).revolve("Z", 360.0);
let spout = cylinder([0, 0, 0], "Z", 2.0, 8.0).rotate([0, 0, 0], "Y", 30.0).translate([0, 0, 1.0]);
let spout_bore = cylinder([0, 0, -1.0], "Z", 0.9, 10.0).rotate([0, 0, 0], "Y", 30.0).translate([0, 0, 1.0]);
body + spout - spout_bore
