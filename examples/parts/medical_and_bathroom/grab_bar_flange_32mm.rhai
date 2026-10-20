// 1-1/4 in (32 mm) grab bar end flange, with snap-on cover: 76 mm flange 3 mm thick, three 4.5 mm countersunk screws on a 58 mm circle, 34 mm collar, 50 mm bar stub
let bar_diameter = 32.0; // [25.0, 40.0] Bar diameter (mm)
let flange_diameter = 76.0; // [60.0, 95.0] Flange diameter (mm)
let screw_circle = 58.0; // [44.0, 80.0] Screw circle diameter (mm)
let bar_stub = 50.0; // [20.0, 120.0] Bar stub length (mm)
const t = 3.0;
let rbar = bar_diameter / 2.0;
let rf = flange_diameter / 2.0;
let rsc = min(screw_circle / 2.0, rf - 5.0);
let flange = cylinder(rf, t);
let collar = cylinder([0, 0, t - 0.1], "Z", rbar + 1.0, 15.0);
let bar = cylinder([0, 0, 14.0], "Z", rbar, bar_stub) - cylinder([0, 0, 13.0], "Z", rbar - 1.25, bar_stub + 2.0);
let part = fuse_all([flange, collar, bar]);
let holes = [];
for i in 0..3 {
    let a = i.to_float() * 120.0;
    holes.push(cylinder([rsc, 0, -1.0], "Z", 2.25, t + 2.0).rotate_z(a));
    holes.push(cone(2.25, 4.5, 2.25).translate([rsc, 0, t - 2.24]).rotate_z(a));
}
part = part - compound(holes);
// cover: a shallow dome that clips over the flange
let rc = rf + 2.0;
let cover = sketch("XZ").move_to(rbar + 0.4, 0.2).hline_to(rc).vline_to(t + 1.5).arc_to(rc * 0.75, t + 9.0, rbar + 1.4, t + 13.0).hline_to(rbar + 0.4).close()
    .to_face().revolve("Z", 360);
cover -= sketch("XZ").move_to(rbar + 1.4, 0).hline_to(rf + 0.3).vline_to(t + 0.4).arc_to(rc * 0.72, t + 7.5, rbar + 1.4, t + 11.0).close()
    .to_face().revolve("Z", 360);
compound([part, cover])
