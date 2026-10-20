// Table corner guard: 40 mm legs, 20 mm deep, for 18 mm tabletops, 5 mm soft ball corner
let leg = 40.0; // [25.0, 60.0] Leg length (mm)
let top = 18.0; // [12.0, 30.0] Tabletop thickness (mm)
let t = 3.0; // [2.0, 5.0] Wall (mm)
let outer = box_from_corners([-t, -t, -t], [leg, leg, top + t]);
let o = outer.fillet(6.0, outer.edges("|Z and <X and <Y"));
o - box_from_corners([0, 0, 0], [leg + 1.0, leg + 1.0, top]) - box_from_corners([leg - 20.0, leg - 20.0, -t - 1.0], [leg + 1.0, leg + 1.0, top + t + 1.0])
