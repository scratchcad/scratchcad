// Vertical bike storage hook: 60 x 80 mm wall plate 6 mm, 120 mm arm with 70 mm rim cradle for up to 65 mm tyres
let tyre = 65.0; // [25.0, 80.0] Max tyre width (mm)
let reach = 120.0; // [80.0, 180.0] Arm reach (mm)
let t = 6.0; // [4.0, 10.0] Plate thickness (mm)
let plate = box_centered(60.0, t, 80.0).translate([0, t / 2.0, 40.0]);
let p = plate.fillet(8.0, plate.edges("|Y"));
let arm = box_from_corners([-10.0, t - 0.01, 30.0], [10.0, reach, 42.0]);
let cradle = box_from_corners([-tyre / 2.0 - 6.0, reach - 20.0, 30.0], [tyre / 2.0 + 6.0, reach, 42.0]) - box_from_corners([-tyre / 2.0, reach - 14.0, 33.0], [tyre / 2.0, reach + 1.0, 43.0]);
let holes = [];
for z in [12.0, 68.0] { holes.push(cylinder([0, -1, z], "Y", 2.75, t + 2.0)); }
p + arm + cradle - compound(holes)
