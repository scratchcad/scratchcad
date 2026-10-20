// Derailleur hanger alignment gauge head: M10 x 1 stud 12 mm long (plain 10 mm cylinder) on a 28 mm hub 16 mm long, 10.2 mm cross bore for the 10 mm gauge rod, M5 set screw hole (4.2 mm) into the cross bore, 1 mm chamfers
let stud_len = 12.0; // [8.0, 16.0] Stud length (mm)
let hub_d = 28.0; // [22.0, 36.0] Hub diameter (mm)
let hub_len = 16.0; // [14.0, 24.0] Hub length (mm)
let rod_d = 10.0; // [8.0, 12.0] Gauge rod diameter (mm)
const stud_d = 10.0;
let hub = cylinder([0, 0, 0], "Z", hub_d / 2.0, hub_len);
let hub = hub.chamfer(1.0, hub.edges(">Z or <Z"));
let stud = cylinder([0, 0, -stud_len], "Z", stud_d / 2.0, stud_len + 0.5);
let stud = stud.chamfer(0.8, stud.edges("<Z"));
let body = hub + stud;
let zc = hub_len / 2.0;
let cuts = fuse_all([
    cylinder([-hub_d, 0, zc], "X", rod_d / 2.0 + 0.1, 2.0 * hub_d),
    cylinder([0, 0, hub_len + 1.0], "-Z", 2.1, hub_len / 2.0 + 1.0),
]);
body - cuts
