// Kart steering wheel boss: 84 mm flange 6 mm thick with three M6 clearance holes (6.4 mm) on a 70 mm PCD, 35 mm hub 45 mm long with a 20 mm column bore, an M8 cross-bolt hole (8.5 mm) 12 mm from the bottom and a 1 mm chamfer on the hub end
let column_d = 20.0; // [16.0, 25.0] Steering column diameter (mm)
let pcd = 70.0; // [50.0, 80.0] Wheel bolt circle diameter (mm)
let hub_len = 45.0; // [32.0, 70.0] Hub length (mm)
let flange_t = 6.0; // [4.0, 10.0] Flange thickness (mm)
const hub_d = 35.0;
let flange_r = pcd / 2.0 + 7.0;
let hub = cylinder([0, 0, 0], "Z", hub_d / 2.0, hub_len - flange_t + 1.0);
let hub = hub.chamfer(1.0, hub.edges("<Z"));
let flange = cylinder([0, 0, hub_len - flange_t], "Z", flange_r, flange_t);
let body = hub + flange;
let cuts = [cylinder([0, 0, -1.0], "Z", column_d / 2.0 + 0.1, hub_len + 2.0)];
cuts.push(cylinder([-hub_d, 0, 12.0], "X", 4.25, 2.0 * hub_d));
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 90.0) * PI() / 180.0;
    cuts.push(cylinder([pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), hub_len - flange_t - 1.0], "Z", 3.2, flange_t + 2.0));
}
body - fuse_all(cuts)
