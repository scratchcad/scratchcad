// X-grip phone mount cradle: 4 arms 45 mm from a 30 mm hub 4 mm thick, 6 mm hooked tips, 1/4 in boss below
let reach = 45.0; // [30.0, 60.0] Arm reach (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let hub = cylinder(15.0, t);
let arms = [];
for k in 0..4 {
    let a = box_from_corners([0, -4.0, 0], [reach, 4.0, t]) + box_from_corners([reach - 3.0, -4.0, 0], [reach, 4.0, t + 6.0]) + box_from_corners([reach - 6.0, -4.0, t + 4.0], [reach, 4.0, t + 6.0]);
    arms.push(a.rotate_z(k.to_float() * 90.0 + 45.0));
}
let boss = cylinder([0, 0, -10.0], "Z", 8.0, 10.01) - cylinder([0, 0, -11.0], "Z", 3.2, 9.0);
hub + fuse_all(arms) + boss
