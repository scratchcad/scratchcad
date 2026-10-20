// Graham escape wheel, 30 teeth: 40 mm tip diameter, 2.5 mm thick, 4 crossed spokes, 3 mm arbor
let teeth = 30; // [15, 40] Number of teeth
let od = 40.0; // [25.0, 80.0] Tip diameter (mm)
let t = 2.5; // [1.0, 5.0] Thickness (mm)
let ro = od / 2.0;
let rr = ro - 3.0;
let pts = [];
for i in 0..teeth {
    let a0 = i.to_float() * 2.0 * PI() / teeth.to_float();
    let da = 2.0 * PI() / teeth.to_float();
    pts.push([rr * a0.cos(), rr * a0.sin()]);
    pts.push([ro * (a0 + da * 0.25).cos(), ro * (a0 + da * 0.25).sin()]);
    pts.push([(ro - 0.6) * (a0 + da * 0.35).cos(), (ro - 0.6) * (a0 + da * 0.35).sin()]);
}
let wheel = polygon(pts).to_face().extrude([0, 0, t]);
let window = cylinder([0, 0, -1], "Z", rr - 2.5, t + 2.0);
let spokes = [];
for k in 0..4 { spokes.push(box_centered(rr * 2.0 - 3.0, 2.0, t).translate([0, 0, t / 2.0]).rotate_z(k.to_float() * 45.0)); }
let hub = cylinder(4.0, t);
wheel - window + (fuse_all(spokes) & cylinder([0, 0, -1], "Z", rr - 2.0, t + 2.0)) + hub - cylinder([0, 0, -1], "Z", 1.5, t + 2.0)
