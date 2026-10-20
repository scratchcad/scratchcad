// Egg cup: revolved profile, 50 mm cup 30 mm deep on a 15 mm stem and 55 mm foot, 2 mm walls
let cup_d = 50.0; // [40.0, 70.0] Cup diameter (mm)
let cup_depth = 30.0; // [20.0, 45.0] Cup depth (mm)
let stem_d = 15.0; // [8.0, 30.0] Stem diameter (mm)
let foot_d = 55.0; // [35.0, 80.0] Foot diameter (mm)
let height = 60.0; // [40.0, 100.0] Overall height (mm)
let wall = 2.0; // [1.2, 4.0] Wall thickness (mm)
let profile = sketch("XZ").move_to(0, 0).hline_to(foot_d / 2.0).vline_to(3.0).arc_to(stem_d * 0.8, 8.0, stem_d / 2.0, 15.0)
    .vline_to(height - cup_depth - 5.0).arc_to(cup_d * 0.45, height - cup_depth + 2.0, cup_d / 2.0, height).hline_to(cup_d / 2.0 - wall)
    .arc_to(cup_d * 0.45 - wall, height - cup_depth + 2.0 + wall, 0, height - cup_depth + wall).close();
profile.to_face().revolve("Z", 360)
