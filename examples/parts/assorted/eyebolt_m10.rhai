// DIN 580 M10 lifting eye bolt
let ring_od = 45.0; // [30, 60] Ring outside diameter (mm)
let eye_d = 25.0; // [15, 40] Eye diameter (mm)
let height = 45.0; // [30, 60] Overall height above the collar face (mm)
let collar_d = 25.0; // [18, 35] Collar diameter (mm)
let collar_h = 8.0; // [5, 12] Collar height (mm)
let shank_length = 17.0; // [10, 30] Thread length (mm)
let diameter = 10.0; // [6, 16] Thread diameter (mm)
let ring_r = (ring_od + eye_d) / 4.0;
let wire_r = (ring_od - eye_d) / 4.0;
// With h equal to the ring's diameter the ring would only touch the collar's base, which
// booleans cannot handle, so its buried lower part is trimmed off inside the collar.
let ring = torus(ring_r, wire_r).rotate_x(90).translate([0, 0, height - ring_od / 2.0])
    & box_from_corners([-ring_od, -ring_od, collar_h / 2.0], [ring_od, ring_od, height + 1.0]);
let neck = cone(collar_d / 2.0, wire_r * 1.2, height - ring_od / 2.0 - ring_r + wire_r * 0.6);
let collar = cylinder(collar_d / 2.0, collar_h);
let shank = cylinder([0, 0, -shank_length], "Z", diameter / 2.0, shank_length + 0.1).chamfer(0.8, "<Z");
fuse_all([ring, neck, collar, shank])
