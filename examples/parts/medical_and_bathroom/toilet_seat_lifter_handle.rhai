// Clip-on toilet seat lifter handle: U clamp for an 18 mm thick seat rim 30 mm deep, 3 mm walls, 70 mm loop handle 12 mm thick standing out 35 mm
let seat_thickness = 18.0; // [12.0, 26.0] Seat rim thickness (mm)
let clamp_depth = 30.0; // [20.0, 45.0] Clamp depth over the rim (mm)
let width = 30.0; // [20.0, 45.0] Clamp width (mm)
let handle_width = 70.0; // [45.0, 100.0] Handle width (mm)
let handle_reach = 35.0; // [20.0, 60.0] Handle reach (mm)
const wall = 3.0;
let hw = width / 2.0;
let clamp = box_from_corners([-hw, -wall, -wall], [hw, clamp_depth, seat_thickness + wall]);
clamp -= box_from_corners([-hw - 1.0, 0, 0], [hw + 1.0, clamp_depth + 1.0, seat_thickness]);
let grips = [];
for i in 0..3 {
    grips.push(cylinder([-hw, clamp_depth * (0.4 + 0.2 * i.to_float()), seat_thickness], "X", 0.8, width));
}
clamp = fuse_all([clamp] + grips);
let hh = handle_width / 2.0;
let path = spline([[-hw * 0.6, -wall + 0.5, seat_thickness * 0.5], [-hh, -handle_reach * 0.6, seat_thickness * 0.5], [0, -handle_reach, seat_thickness * 0.5],
                   [hh, -handle_reach * 0.6, seat_thickness * 0.5], [hw * 0.6, -wall + 0.5, seat_thickness * 0.5]]);
let loop_bar = circle(path.start_point(), path.tangent_at(0.0), 6.0).to_face().sweep(wire([path]));
fuse_all([clamp, loop_bar])
