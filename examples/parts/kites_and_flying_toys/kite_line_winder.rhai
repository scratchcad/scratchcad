// Kite line winder: 180 x 120 mm H-frame winder 8 mm thick, 30 mm deep winding notches at each end, two 25 mm hand holes and 2 mm line slots
let length = 180.0; // [120.0, 250.0] Winder length (mm)
let width = 120.0; // [80.0, 160.0] Winder width (mm)
const t = 8.0;
let w = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let w = w.fillet(10.0, w.edges("|Z"));
let notches = box_centered(width * 0.6, 60.0, t + 2.0).translate([0, length / 2.0, t / 2.0]).rotate_z(90.0) + box_centered(width * 0.6, 60.0, t + 2.0).translate([0, -length / 2.0, t / 2.0]).rotate_z(90.0);
let holes = cylinder([-length * 0.15, 0, -1.0], "Z", 12.5, t + 2.0) + cylinder([length * 0.15, 0, -1.0], "Z", 12.5, t + 2.0);
let slot = box_centered(10.0, 2.0, t + 2.0).translate([length / 2.0 - 30.0 - 5.0, width / 2.0 - 1.0, t / 2.0]);
w - notches - holes - slot
