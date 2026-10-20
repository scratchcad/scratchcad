// Emergency shower pull handle: triangular pull ring 150 mm per side from 12 mm rod, ball-jointed corners, 20 mm eye at the apex for the 6 mm pull rod
let side = 150.0; // [100.0, 200.0] Triangle side (mm)
let rod = 12.0; // [8.0, 16.0] Rod diameter (mm)
let eye = 20.0; // [14.0, 28.0] Eye diameter (mm)
let h = side * 3.0.sqrt() / 2.0;
let corners = [[-side / 2.0, 0.0, 0.0], [side / 2.0, 0.0, 0.0], [0.0, 0.0, h]];
let parts = [];
for i in 0..3 {
    let a = corners[i];
    let b = corners[(i + 1) % 3];
    let d = [b[0] - a[0], b[1] - a[1], b[2] - a[2]];
    let len = (d[0] * d[0] + d[2] * d[2]).sqrt();
    parts.push(cylinder(a, d, rod / 2.0, len));
    // corner balls a little larger than the rod so the elbows join cleanly
    parts.push(sphere(a, rod / 2.0 + 0.5));
}
let ring = cylinder([0, -rod / 2.0, h + eye / 2.0 + 2.0], "Y", eye / 2.0 + 4.0, rod) - cylinder([0, -rod, h + eye / 2.0 + 2.0], "Y", 3.5, rod * 2.0);
fuse_all(parts) + ring
