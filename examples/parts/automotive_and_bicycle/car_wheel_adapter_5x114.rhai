// 20 mm bolt-on wheel adapter 5x114.3: 145 mm disc, 66.1 mm hub-centric bore and lip, M12x1.5 studs offset 36 deg from the nut pockets
let pcd = 114.3; // [100.0, 120.0] Pitch circle diameter (mm)
let t = 20.0; // [15.0, 35.0] Thickness (mm)
let bore = 66.1; // [54.1, 72.6] Hub bore (mm)
let disc = cylinder(72.5, t) + cylinder([0, 0, t], "Z", bore / 2.0, 5.0);
disc -= cylinder([0, 0, -1], "Z", bore / 2.0 - 4.0, t + 7.0);
disc -= cylinder([0, 0, -1], "Z", bore / 2.0, 9.0);
for k in 0..5 {
    let a = k.to_float() * 72.0;
    disc -= cylinder([pcd / 2.0, 0, -1], "Z", 7.25, t + 2.0).rotate("Z", a);
    disc -= cylinder([pcd / 2.0, 0, 8.0], "Z", 12.0, t).rotate("Z", a);
}
let studs = [];
for k in 0..5 { studs.push(cylinder([pcd / 2.0, 0, t - 8.0], "Z", 6.0, 43.0).rotate("Z", 36.0 + k.to_float() * 72.0)); }
fuse_all([disc] + studs)
