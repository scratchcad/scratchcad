// Eyeglass frame hinge, 3-barrel: 2.2 mm knuckles 1.4 mm tall with 0.1 mm gaps, 1.2 mm screw hole for an M1.4 hinge screw; the front part carries two knuckles, the temple part one
let barrel_diameter = 2.2; // [1.6, 3.0] Barrel diameter (mm)
let knuckle_height = 1.4; // [1.0, 2.0] Knuckle height (mm)
let screw_hole = 1.2; // [0.8, 1.6] Screw hole diameter (mm)
let plate_length = 7.0; // [4.0, 12.0] Plate length (mm)
let plate_thickness = 1.4; // [0.8, 2.0] Plate thickness (mm)
const gap = 0.1;
let rb = barrel_diameter / 2.0;
let kh = knuckle_height;
let total = 3.0 * kh + 2.0 * gap;
let hole = cylinder([0, 0, -1], "Z", screw_hole / 2.0, total + 2.0);
// front part: lower and upper knuckles and a plate towards -X, cleared around the middle knuckle
let front = cylinder(rb, kh) + cylinder([0, 0, 2.0 * kh + 2.0 * gap], "Z", rb, kh);
front = front + box_from_corners([-plate_length, -plate_thickness / 2.0, 0], [-rb * 0.5, plate_thickness / 2.0, total]);
front = front - cylinder([0, 0, kh], "Z", rb + gap, kh + 2.0 * gap) - hole;
// temple part: middle knuckle and a plate towards +X
let temple = cylinder([0, 0, kh + gap], "Z", rb, kh) + box_from_corners([rb * 0.5, -plate_thickness / 2.0, kh + gap], [plate_length, plate_thickness / 2.0, 2.0 * kh + gap]);
temple = temple - hole;
[front, temple]
