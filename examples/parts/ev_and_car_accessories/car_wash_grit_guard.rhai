// Car wash bucket grit guard: 264 mm disc for a 5 gallon bucket, 4 concentric rings and 24 radial vanes 3 mm thick, 12 mm deep grid, solid 50 mm hub, 4 legs 45 mm tall
let diameter = 264.0; // [220.0, 300.0] Bucket bottom diameter (mm)
let vanes = 24; // [12, 36] Number of radial vanes
let rings = 4; // [2, 6] Number of inner rings
let grid_h = 12.0; // [8.0, 20.0] Grid depth (mm)
let leg_h = 45.0; // [25.0, 70.0] Leg height (mm)

const t = 3.0;
const hub_r = 25.0;
let r_out = diameter / 2.0 - 1.0;
let z0 = leg_h;
let parts = [cylinder([0, 0, z0], "Z", r_out, grid_h) - cylinder([0, 0, z0 - 1.0], "Z", r_out - t, grid_h + 2.0)];
parts.push(cylinder([0, 0, z0], "Z", hub_r, grid_h));
for k in 1..=rings {
    let r = hub_r + k * (r_out - hub_r) / (rings + 1);
    parts.push(cylinder([0, 0, z0], "Z", r + t / 2.0, grid_h) - cylinder([0, 0, z0 - 1.0], "Z", r - t / 2.0, grid_h + 2.0));
}
for i in 0..vanes {
    parts.push(box_from_corners([hub_r - 2.0, -t / 2.0, z0], [r_out - 1.0, t / 2.0, z0 + grid_h]).rotate_z(i * 360.0 / vanes));
}
for i in 0..4 {
    // legs sit under the outer ring, between vanes
    let a = (i * 90.0 + 360.0 / vanes / 2.0) * PI() / 180.0;
    let rl = r_out - 9.0;
    parts.push(cylinder([rl * cos(a), rl * sin(a), 0], "Z", 6.0, leg_h + 1.0) + cylinder([rl * cos(a), rl * sin(a), leg_h], "Z", 8.0, 3.0));
}
fuse_all(parts)
