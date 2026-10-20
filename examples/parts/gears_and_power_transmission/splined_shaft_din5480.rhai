// Involute-style splined shaft end approximated by 18 straight splines: 25 mm major, 22 mm minor, 30 mm long spline on a 25 mm shaft
let major = 25.0; // [10.0, 60.0] Major diameter (mm)
let minor = 22.0; // [8.0, 55.0] Minor diameter (mm)
let splines = 18; // [6, 40] Splines
let spline_l = 30.0; // [10.0, 80.0] Spline length (mm)
let shaft_l = 60.0; // [20.0, 200.0] Plain shaft length (mm)
let core = cylinder(minor / 2.0, spline_l);
let width = PI() * minor / splines.to_float() * 0.5;
let teeth = [];
for i in 0..splines { teeth.push(box_from_corners([minor / 2.0 - 0.3, -width / 2.0, 0], [major / 2.0, width / 2.0, spline_l]).rotate_z(i.to_float() * 360.0 / splines.to_float())); }
// the end chamfer comes from intersecting with a chamfered cylinder, not from chamfering 36 spline edges
let spline = fuse_all([core] + teeth) & cylinder(major / 2.0, spline_l).chamfer(1.0, ">Z");
spline + cylinder([0, 0, -shaft_l], "Z", major / 2.0, shaft_l + 0.01)
