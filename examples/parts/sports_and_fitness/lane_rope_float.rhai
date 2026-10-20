// Swimming lane line wave-breaker float: 110 mm discs on a 30 mm hub 100 mm long with a 14 mm cable bore, three 4 mm discs, eight 2.5 mm turbine blades between each pair
let disc_d = 110.0; // [80.0, 150.0] Disc diameter (mm)
let length = 100.0; // [60.0, 150.0] Float length (mm)
let hub_d = 30.0; // [22.0, 40.0] Hub diameter (mm)
let cable_bore = 14.0; // [8.0, 20.0] Cable bore (mm)
let blades = 8; // [4, 12] Number of blades per bay
const disc_t = 4.0;
const blade_t = 2.5;
let r = disc_d / 2.0;
let parts = [cylinder(hub_d / 2.0, length)];
for z in [0.0, (length - disc_t) / 2.0, length - disc_t] { parts.push(cylinder([0, 0, z], "Z", r, disc_t)); }
let bay = (length - 3.0 * disc_t) / 2.0;
for k in 0..2 {
    let z0 = disc_t + k.to_float() * (bay + disc_t) - 0.2;
    for i in 0..blades {
        let a = i.to_float() * 360.0 / blades.to_float() + k.to_float() * 180.0 / blades.to_float();
        parts.push(box_from_corners([hub_d / 2.0 - 1.0, -blade_t / 2.0, z0], [r - 2.0, blade_t / 2.0, z0 + bay + 0.4]).rotate_z(a));
    }
}
let float = fuse_all(parts);
float - cylinder([0, 0, -1.0], "Z", cable_bore / 2.0, length + 2.0)
