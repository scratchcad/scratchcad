// M20 knockout blanking plug: 20.5 mm hole, 25 mm cap 2 mm, 3 snap fingers 6 mm for 1 to 3 mm walls
let hole = 20.5; // [16.0, 32.5] Knockout hole (mm)
let cap = 25.0; // [20.0, 40.0] Cap diameter (mm)
let c = cylinder(cap / 2.0, 2.0);
let fingers = [];
for k in 0..3 {
    let f = (cylinder([0, 0, -6.0], "Z", hole / 2.0 - 0.2, 6.01) - cylinder([0, 0, -7.0], "Z", hole / 2.0 - 1.4, 8.0)) & box_from_corners([-3.5, 0, -7.0], [3.5, hole, 1.0]);
    let barb = (cylinder([0, 0, -5.0], "Z", hole / 2.0 + 0.6, 1.5) - cylinder([0, 0, -6.0], "Z", hole / 2.0 - 1.4, 3.0)) & box_from_corners([-3.5, 0, -6.0], [3.5, hole, -3.0]);
    fingers.push((f + barb).rotate_z(k.to_float() * 120.0));
}
c + fuse_all(fingers)
