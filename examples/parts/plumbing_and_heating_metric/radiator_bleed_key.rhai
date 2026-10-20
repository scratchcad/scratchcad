// Radiator bleed key for 5 mm square bleed valves: 9 mm barrel 16 mm long, 5.3 mm square socket 7 mm deep, 26 x 16 mm wing 3 mm thick with 4 mm key-ring hole
let square = 5.3; // [4.0, 7.5] Socket across flats (mm)
let socket_depth = 7.0; // [4.0, 10.0] Socket depth (mm)
let barrel_d = 9.0; // [8.0, 14.0] Barrel diameter (mm)
let barrel_h = 16.0; // [10.0, 30.0] Barrel length (mm)
let wing_w = 26.0; // [18.0, 40.0] Wing width (mm)
let wing_h = 16.0; // [10.0, 24.0] Wing height (mm)
let wing_t = 3.0; // [2.0, 5.0] Wing thickness (mm)
let bd = max(barrel_d, square * 1.42 + 2.0);
let barrel = cylinder(bd / 2.0, barrel_h);
let barrel = barrel.chamfer(0.6, barrel.edges("<Z"));
let wing = box_centered(wing_w, wing_t, wing_h).translate([0, 0, barrel_h + wing_h / 2.0 - 3.0]);
let wing = wing.fillet(min(wing_w, wing_h) * 0.25, wing.edges("|Y"));
let ring_hole = cylinder([0, -wing_t, barrel_h + wing_h - 7.0], "Y", 2.0, wing_t * 3.0);
let socket = box_centered(square, square, socket_depth * 2.0);
barrel + wing - ring_hole - socket
