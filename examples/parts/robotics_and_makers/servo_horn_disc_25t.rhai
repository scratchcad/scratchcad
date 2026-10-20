// Round servo horn disc for 25-tooth (MG996R style) splines: 25 mm disc 2.5 mm thick, 8 mm hub 6 mm tall with a 25T 5.9 mm spline bore, M3 screw counterbore, 8 holes on 16 and 21 mm circles
let disc_d = 25.0; // [18.0, 40.0] Disc diameter (mm)
let disc_t = 2.5; // [1.5, 4.0] Disc thickness (mm)
let hub_h = 6.0; // [3.0, 9.0] Hub height (mm)
let spline_d = 5.9; // [4.5, 6.5] Spline diameter (mm)
const teeth = 25;
let rd = disc_d / 2.0;
let horn = cylinder(rd, disc_t).fillet(0.6, ">Z") + cylinder([0, 0, 0], "Z", 5.0, hub_h);
let pts = [];
for i in 0..(2 * teeth) {
    let a = i.to_float() * 180.0 / teeth.to_float() * PI() / 180.0;
    let r = if i % 2 == 0 { spline_d / 2.0 } else { spline_d / 2.0 - 0.35 };
    pts.push([r * a.cos(), r * a.sin()]);
}
horn -= polygon(pts).to_face().extrude([0, 0, hub_h - 1.5]).translate([0, 0, -0.5]);
horn -= cylinder([0, 0, -1], "Z", 1.6, hub_h + 2.0) + cylinder([0, 0, hub_h - 1.5], "Z", 3.0, 2.0);
let holes = [];
for i in 0..4 {
    holes.push(cylinder([8.0, 0, -1], "Z", 0.8, disc_t + 2.0).rotate_z(i.to_float() * 90.0));
    holes.push(cylinder([min(10.5, rd - 1.8), 0, -1], "Z", 0.8, disc_t + 2.0).rotate_z(i.to_float() * 90.0 + 45.0));
}
horn - fuse_all(holes)
