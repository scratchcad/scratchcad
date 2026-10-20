// Double robe hook: 60 x 34 mm oval wall plate 8 mm thick with two countersunk screws, 8 mm rod arms reaching 50 mm (lower) and 32 mm (upper, rising 55 mm), ball ends
let rod = 8.0; // [5.0, 12.0] Arm rod diameter (mm)
let lower_reach = 50.0; // [30.0, 80.0] Lower arm reach (mm)
let upper_reach = 32.0; // [20.0, 60.0] Upper arm reach (mm)
let upper_rise = 55.0; // [30.0, 90.0] Upper arm rise (mm)
let plate_height = 60.0; // [40.0, 90.0] Plate height (mm)
let r = rod / 2.0;
let ph = plate_height / 2.0;
let plate = (cylinder([0, 0, 0], "Y", 17.0, 8.0) + box_from_corners([-17.0, 0, -ph + 17.0], [17.0, 8.0, ph - 17.0])
    + cylinder([0, 0, ph - 17.0], "Y", 17.0, 8.0) + cylinder([0, 0, -ph + 17.0], "Y", 17.0, 8.0)).fillet(2.5, ">Y");
for z in [ph - 12.0, -ph + 12.0] {
    plate -= cylinder([0, -1.0, z], "Y", 2.2, 10.0);
    plate -= cone(2.2, 4.4, 2.2).rotate_x(-90.0).translate([0, 5.81, z]);
}
let lower = spline([[0, 6.0, -8.0], [0, lower_reach * 0.5, -12.0], [0, lower_reach * 0.9, -4.0], [0, lower_reach, 8.0]]);
let upper = spline([[0, 6.0, 4.0], [0, upper_reach * 0.6, upper_rise * 0.3], [0, upper_reach * 0.9, upper_rise * 0.7], [0, upper_reach, upper_rise]]);
let arms = [];
for path in [lower, upper] {
    arms.push(circle(path.start_point(), path.tangent_at(0.0), r).to_face().sweep(wire([path])));
    arms.push(sphere(path.end_point(), r + 1.5));
}
fuse_all([plate] + arms)
