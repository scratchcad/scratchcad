// Marine engine exhaust elbow gasket, 3-bolt: 1.5 mm triangular flange gasket with 14 mm rounded lobes, a 50 mm port and three 10.5 mm bolt holes on an 82 mm PCD
let port_d = 50.0; // [35.0, 70.0] Port diameter (mm)
let pcd = 82.0; // [65.0, 110.0] Bolt circle diameter (mm)
let thickness = 1.5; // [0.8, 3.0] Gasket thickness (mm)
let bolt_hole = 10.5; // [6.5, 12.5] Bolt hole diameter (mm)
let p = max(pcd, port_d + bolt_hole + 12.0);
let pts = [];
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 90.0) * PI() / 180.0;
    pts.push([p / 2.0 * cos(a), p / 2.0 * sin(a), 0.0]);
}
let core = face(polygon(pts)).extrude([0, 0, thickness]);
let parts = [core, cylinder([0, 0, 0], "Z", port_d / 2.0 + 6.0, thickness)];
for q in pts {
    parts.push(cylinder(q, "Z", bolt_hole / 2.0 + 6.0, thickness));
}
let g = fuse_all(parts);
let cuts = [cylinder([0, 0, -1.0], "Z", port_d / 2.0, thickness + 2.0)];
for q in pts {
    cuts.push(cylinder([q[0], q[1], -1.0], "Z", bolt_hole / 2.0, thickness + 2.0));
}
g - fuse_all(cuts)
