// Kart brake disc carrier for a 50 mm axle: three-lobed flange 8 mm thick with M8 tapped holes (6.8 mm core) on a 100 mm PCD, 70 mm hub 35 mm long with a 50 mm bore, 8 mm keyway, and a 2 mm clamp split with two M6 pinch screw holes (6.4 mm) through a 16 mm lug
let axle_d = 50.0; // [30.0, 50.0] Axle diameter (mm)
let pcd = 100.0; // [90.0, 130.0] Disc bolt circle (mm)
let hub_len = 35.0; // [25.0, 50.0] Hub length (mm)
const flange_t = 8.0;
const lobe_r = 12.0;
let hr = axle_d / 2.0 + 10.0;
let lobes = [cylinder([0, 0, 0], "Z", hr + 5.0, flange_t)];
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 90.0) * PI() / 180.0;
    let x = pcd / 2.0 * cos(a);
    let y = pcd / 2.0 * sin(a);
    lobes.push(cylinder([x, y, 0], "Z", lobe_r, flange_t));
    lobes.push(box_centered(pcd / 2.0, 2.0 * lobe_r, flange_t).translate([pcd / 4.0, 0, flange_t / 2.0]).rotate_z(i.to_float() * 120.0 + 90.0));
}
let hub = cylinder([0, 0, 0], "Z", hr, hub_len);
let lug = box_from_corners([-8.0, -hr - 10.0, flange_t], [8.0, -hr + 2.0, hub_len]);
let body = fuse_all(lobes) + hub + lug;
let cuts = [
    cylinder([0, 0, -1.0], "Z", axle_d / 2.0, hub_len + 2.0),
    box_from_corners([-4.0, 0, -1.0], [4.0, axle_d / 2.0 + 4.0, hub_len + 1.0]),
    box_from_corners([-1.0, -hr - 11.0, flange_t + 2.0], [1.0, -axle_d / 2.0 + 1.0, hub_len + 1.0])
];
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 90.0) * PI() / 180.0;
    cuts.push(cylinder([pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), -1.0], "Z", 3.4, flange_t + 2.0));
}
let zs = flange_t + 2.0 + (hub_len - flange_t - 2.0) / 2.0;
cuts.push(cylinder([-9.0, -hr - 5.0, zs], "X", 3.2, 18.0));
body - fuse_all(cuts)
