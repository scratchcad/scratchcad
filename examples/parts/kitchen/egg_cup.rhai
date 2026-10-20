// Egg cup for a large hen's egg (43 x 57 mm): 44 mm cup 28 mm deep, 3 mm wall, 12 mm waisted stem, 55 mm foot
let cup_inside = 44.0; // [36.0, 55.0] Cup inside diameter (mm)
let cup_depth = 28.0; // [20.0, 40.0] Cup depth (mm)
let wall = 3.0; // [1.5, 5.0] Wall thickness (mm)
let stem_height = 18.0; // [5.0, 40.0] Stem height (mm)
let foot_diameter = 55.0; // [40.0, 80.0] Foot diameter (mm)
let ri = cup_inside / 2.0;
let rf = foot_diameter / 2.0;
let z1 = 3.0 + stem_height;
let p = sketch("XZ").move_to(0, 0).hline_to(rf).arc_to(rf - 1.0, 2.5, rf - 3.0, 3.0).arc_to(8.0, 3.0 + stem_height * 0.5, 12.0, z1)
    .arc_to(ri + wall, z1 + cup_depth * 0.45, ri + wall, z1 + cup_depth + wall).hline(-wall).vline_to(z1 + wall + ri * 0.6).arc_to(ri * 0.7, z1 + wall + ri * 0.15, 0, z1 + wall)
    .close();
p.to_face().revolve("Z", 360)
