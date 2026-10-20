// Electric fence ring insulator for wooden posts: 50 mm, 8 mm wire slot, 6 mm screw hole, rain skirt
let length = 50.0; // [35.0, 70.0] Overall length (mm)
let ring = 18.0; // [12.0, 25.0] Ring diameter (mm)
let t = 8.0; // [5.0, 12.0] Thickness (mm)
let stem = box_from_corners([0, -t / 2.0, -t / 2.0], [length - ring / 2.0, t / 2.0, t / 2.0]);
let base = box_from_corners([-3.0, -12.0, -12.0], [0.01, 12.0, 12.0]);
let eye = cylinder([length - ring / 2.0, 0, -t / 2.0], "Z", ring / 2.0, t) - cylinder([length - ring / 2.0, 0, -t], "Z", ring / 2.0 - 4.0, 2.0 * t) - box_from_corners([length - ring / 2.0 - 1.0, 0, -t], [length + 1.0, 1.5, t]);
let skirt = cylinder([8.0, 0, 0], "X", 10.0, 2.0);
stem + base + eye + skirt - cylinder([-4.0, 0, 0], "X", 3.0, 14.0)
