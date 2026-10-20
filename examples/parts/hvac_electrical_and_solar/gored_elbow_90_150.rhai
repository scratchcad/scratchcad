// 4-gore 90 degree round duct elbow, 6 in (150 mm), centreline radius 1.5 D (225 mm), 0.8 mm wall, 50 mm straight collars at both ends
let duct_d = 150.0; // [80.0, 300.0] Duct diameter (mm)
let bend_ratio = 1.5; // [1.0, 2.5] Centreline radius over diameter
let gores = 4; // [3, 6] Number of gores
let collar = 50.0; // [20.0, 100.0] Collar length (mm)
const t = 0.8;
let r = duct_d / 2.0;
let rc = bend_ratio * duct_d;
let full = 90.0 / (gores - 1).to_float();
fn gore_body(rc, r, a0, a1) {
    let am = (a0 + a1) / 2.0;
    let half = (a1 - a0) / 2.0;
    let len = 2.0 * (rc + r) * (half * PI() / 180.0).tan() + 2.0;
    let cyl = cylinder([rc, -len / 2.0, 0], "Y", r, len).rotate_z(am);
    let big = 3.0 * (rc + r);
    let wedge = polygon([[0, 0], [big * (a0 * PI() / 180.0).cos(), big * (a0 * PI() / 180.0).sin()], [big * (am * PI() / 180.0).cos() * 1.5, big * (am * PI() / 180.0).sin() * 1.5], [big * (a1 * PI() / 180.0).cos(), big * (a1 * PI() / 180.0).sin()]])
        .to_face().extrude([0, 0, 4.0 * r]).translate([0, 0, -2.0 * r]);
    cyl & wedge
}
let edges = [0.0, full / 2.0];
for i in 1..(gores - 1) { edges.push(full / 2.0 + i.to_float() * full); }
edges.push(90.0);
let outer = [cylinder([rc, -collar, 0], "Y", r, collar + 0.01), cylinder([-collar, rc, 0], "X", r, collar + 0.01).rotate_z(0.0)];
let inner = [cylinder([rc, -collar - 1.0, 0], "Y", r - t, collar + 1.02), cylinder([-collar - 1.0, rc, 0], "X", r - t, collar + 1.02)];
outer[1] = cylinder([0, rc, 0], "-X", r, collar);
inner[1] = cylinder([1.0, rc, 0], "-X", r - t, collar + 2.0);
for i in 0..(edges.len() - 1) {
    outer.push(gore_body(rc, r, edges[i], edges[i + 1]));
    inner.push(gore_body(rc, r - t, edges[i] - 0.01, edges[i + 1] + 0.01));
}
fuse_all(outer) - fuse_all(inner)
