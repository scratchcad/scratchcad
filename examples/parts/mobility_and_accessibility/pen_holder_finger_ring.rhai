// Pen holder finger ring: writing aid that slips over the index finger, 20 mm finger ring 12 mm wide with 2.5 mm wall, linked by a 15 mm bridge to an 11 mm pen tube 25 mm long at 30 degrees
// # Finger
let finger = 20.0; // [15.0, 26.0] Finger diameter (mm)
let ring_width = 12.0; // [8.0, 18.0] Ring width (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
// # Pen
let pen = 11.0; // [7.0, 14.0] Pen diameter (mm)
let pen_tube = 25.0; // [15.0, 40.0] Pen tube length (mm)
let pen_angle = 30.0; // [0.0, 45.0] Pen angle (degrees)
let rf = finger / 2.0 + wall;
let rp = pen / 2.0 + wall;
let ring = cylinder([0, 0, 0], "Z", rf, ring_width) - cylinder([0, 0, -1.0], "Z", finger / 2.0, ring_width + 2.0);
let cy = -(rf + rp - 1.5);
let tube = (cylinder([0, 0, -pen_tube / 2.0], "Z", rp, pen_tube) - cylinder([0, 0, -pen_tube / 2.0 - 1.0], "Z", pen / 2.0, pen_tube + 2.0)).rotate_x(pen_angle).translate([0, cy, ring_width / 2.0]);
let bridge = box_from_corners([-wall, cy + rp * 0.5, ring_width / 2.0 - 4.0], [wall, -finger / 2.0 - 0.5, ring_width / 2.0 + 4.0]);
let bridge_c = bridge - cylinder([0, 0, -1.0], "Z", finger / 2.0, ring_width + 2.0) - cylinder([0, 0, -pen_tube], "Z", pen / 2.0, pen_tube * 2.0).rotate_x(pen_angle).translate([0, cy, ring_width / 2.0]);
ring + tube + bridge_c
