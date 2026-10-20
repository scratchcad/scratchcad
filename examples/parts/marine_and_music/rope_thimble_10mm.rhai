// Rope thimble for 10 mm rope: teardrop eye 30 x 45 mm inside, U-section 1.5 mm sheet with a 11 mm groove
let rope = 10.0; // [4.0, 20.0] Rope diameter (mm)
let w = rope + 4.0;
let g = rope / 2.0 + 0.5;
let path = [[0, 0, 0], [16.0, 0, 18.0], [16.0, 0, 35.0], [0, 0, 50.0], [-16.0, 0, 35.0], [-16.0, 0, 18.0]];
let outer = polygon([[0, 0], [w / 2.0, 0], [w / 2.0, w * 0.55], [-w / 2.0, w * 0.55], [-w / 2.0, 0]]);
let ring = torus(22.0, w / 2.0) - torus(22.0, g);
let eye = (ring - box_centered(60.0, 60.0, 60.0).translate([0, 0, -30.0 - 0.0]).rotate_y(0.0)) & box_centered(80.0, 80.0, w * 2.0);
let half = ring & box_from_corners([-40, -40, -20], [40, 0, 20]);
let lips = [];
let thimble = ring - torus(22.0, g).translate([0, 0, 0]) - box_centered(100.0, 100.0, 2.0 * g).translate([0, 0, 0]).scale(1.0) & box_from_corners([-40, -40, -w], [40, 40, 0.01]);
thimble = (torus(22.0, w / 2.0) - torus(22.0, g)) & box_from_corners([-40, -40, -w], [40, 40, 0]);
let point = (cylinder([-6.0, -26.0, -w / 2.0], "Z", 6.0, w / 2.0) + box_from_corners([-6.0, -40.0, -w / 2.0], [6.0, -26.0, 0])) & box_centered(16.0, 60.0, 30.0);
thimble + polygon([[0, -38, 0], [10, -20, 0], [-10, -20, 0]]).to_face().extrude(-w / 2.0) - torus(22.0, g)
