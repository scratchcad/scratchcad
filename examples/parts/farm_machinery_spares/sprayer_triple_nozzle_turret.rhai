// Sprayer triple nozzle turret rotor: 32 mm hub 22 mm thick with a 12 mm pivot bore for the turret spindle, three 18 mm bayonet outlets standing 14 mm out at 120 degrees, each with two 4 mm lugs 2.5 mm proud near its end and a 6 mm passage into a 4 mm feed hole drilled parallel to the spindle
let hub_d = 32.0; // [26.0, 44.0] Hub diameter (mm)
let hub_t = 22.0; // [18.0, 30.0] Hub thickness (mm)
let outlet_d = 18.0; // [14.0, 22.0] Outlet diameter (mm)
let outlet_len = 14.0; // [8.0, 22.0] Outlet length beyond the hub (mm)
let pivot_d = 12.0; // [8.0, 16.0] Pivot bore (mm)
const lug_w = 4.0;
const lug_proud = 2.5;
const lug_t = 2.5;
const passage = 6.0;
const feed = 4.0;
let rh = max(hub_d / 2.0, pivot_d / 2.0 + feed + 5.0);
let ro = min(outlet_d / 2.0, hub_t / 2.0 - 1.0);
let zc = hub_t / 2.0;
let x_end = rh + outlet_len;
let parts = [cylinder(rh, hub_t)];
let cutters = [cylinder([0, 0, -1.0], "Z", pivot_d / 2.0, hub_t + 2.0)];
let rfeed = pivot_d / 2.0 + feed / 2.0 + 2.0;
for i in 0..3 {
    let a = i * 120.0;
    parts.push(cylinder([rh * 0.5, 0, zc], "X", ro, outlet_len + rh * 0.5).rotate_z(a));
    for s in [-1.0, 1.0] {
        let za = zc + s * (ro - 0.5);
        let zb = zc + s * (ro + lug_proud);
        parts.push(box_from_corners([x_end - lug_t - 1.0, -lug_w / 2.0, min(za, zb)], [x_end - 1.0, lug_w / 2.0, max(za, zb)]).rotate_z(a));
    }
    cutters.push(cylinder([rfeed, 0, zc], "X", passage / 2.0, x_end + 1.0 - rfeed).rotate_z(a));
    cutters.push(cylinder([rfeed, 0, -1.0], "Z", feed / 2.0, zc + 1.0).rotate_z(a));
}
fuse_all(parts) - fuse_all(cutters)
