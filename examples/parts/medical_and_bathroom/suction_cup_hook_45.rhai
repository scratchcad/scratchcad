// Suction cup bathroom hook: 45 mm suction dome 2 mm thick, 10 mm stem with a lever cap, 5 mm J hook 30 mm long
let cup_diameter = 45.0; // [30.0, 70.0] Suction cup diameter (mm)
let cup_depth = 7.0; // [4.0, 12.0] Cup depth (mm)
let hook_length = 30.0; // [15.0, 50.0] Hook length (mm)
let hook_rod = 5.0; // [3.0, 8.0] Hook rod diameter (mm)
let R = cup_diameter / 2.0;
let cup = sketch("XZ").move_to(0, cup_depth + 2.0).arc_to(R * 0.6, cup_depth * 0.75 + 2.0, R, 0).hline(-1.0).arc_to(R * 0.6 - 1.0, cup_depth * 0.75, 0, cup_depth).close()
    .to_face().revolve("Z", 360);
let stem = cylinder([0, 0, cup_depth], "Z", 5.0, 10.0);
let cap = cylinder([0, 0, cup_depth + 10.0], "Z", 9.0, 4.0).fillet(1.5, ">Z");
let r = hook_rod / 2.0;
let z0 = cup_depth + 14.0;
let path = spline([[0, 0, z0 - 0.5], [0, 0, z0 + hook_length * 0.5], [0, -4.0, z0 + hook_length * 0.85], [0, -10.0, z0 + hook_length * 0.9], [0, -13.0, z0 + hook_length * 0.7]]);
let hook = circle(path.start_point(), path.tangent_at(0.0), r).to_face().sweep(wire([path]));
fuse_all([cup, stem, cap, hook, sphere(path.end_point(), r)])
