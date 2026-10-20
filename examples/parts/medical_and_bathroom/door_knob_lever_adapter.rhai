// Door knob lever adapter: split clamp ring for 55 mm round knobs, 25 mm tall, 120 mm lever arm, M5 clamp screw across the split
let knob_diameter = 55.0; // [45.0, 70.0] Door knob diameter (mm)
let ring_height = 25.0; // [15.0, 35.0] Ring height (mm)
let lever_length = 120.0; // [70.0, 180.0] Lever length from the knob centre (mm)
let wall = 5.0; // [3.0, 8.0] Ring wall (mm)
let ri = knob_diameter / 2.0;
let ro = ri + wall;
let ring = cylinder(ro, ring_height);
let lever = box_from_corners([0, -10.0, 0], [lever_length, 10.0, 12.0]).fillet(9.0, "|Z and >X");
let ears = box_from_corners([-ro - 12.0, -8.0, 0], [-ro + 3.0, 8.0, ring_height]);
let body = fuse_all([ring, lever, ears]);
body -= cylinder([0, 0, -1.0], "Z", ri, ring_height + 2.0);
body -= box_from_corners([-ro - 13.0, -1.0, -1.0], [-ri + 1.0, 1.0, ring_height + 1.0]);
body -= cylinder([-ro - 5.0, -10.0, ring_height / 2.0], "Y", 2.7, 20.0);
body.fillet(1.0, ">Z and |X")
