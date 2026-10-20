// 4 in octagon steel ceiling junction box, 1-1/2 in deep: 101.6 mm across flats, 38 mm deep, 1.6 mm wall, 22 mm knockouts on alternate sides, two 8-32 mounting ears 89 mm (3.5 in) apart
let across = 101.6; // [76.0, 120.0] Across flats (mm)
let depth = 38.0; // [25.0, 60.0] Box depth (mm)
let ko_d = 22.2; // [12.0, 28.0] Knockout diameter (mm)
const t = 1.6;
const ear_spacing = 88.9;
let rc = across / 2.0 / (22.5 * PI() / 180.0).cos();
fn octo(rc, h, z0) {
    let pts = [];
    for i in 0..8 { let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
    polygon(pts).to_face().extrude([0, 0, h]).translate([0, 0, z0])
}
let b = octo(rc, depth, 0.0) - octo(rc - t / (22.5 * PI() / 180.0).cos(), depth, t);
let kd = min(ko_d, depth - 8.0);
let kos = [];
for i in 0..4 {
    let a = i.to_float() * 90.0;
    kos.push(cylinder([across / 2.0 - 3.0, 0, depth / 2.0], "X", kd / 2.0, 6.0).rotate_z(a));
}
b -= fuse_all(kos);
b -= cylinder([0, 0, -1], "Z", kd / 2.0, 4.0);
let ears = [];
for s in [-1.0, 1.0] {
    let y = s * ear_spacing / 2.0;
    ears.push(box_from_corners([-6.0, y - s * 8.0, depth - t - 6.0], [6.0, y + s * 5.0, depth - t]) - cylinder([0, y, depth - 15.0], "Z", 1.7, 20.0));
}
fuse_all([b] + ears)
