// Picture frame D-ring hanger: 25 x 12 mm strap plate 1.5 mm thick with a 3.5 mm screw hole, carrying a 20 mm wide D-ring of 3 mm round bar standing 15 mm
let ring_w = 20.0; // [14.0, 30.0] Ring width (mm)
let ring_h = 15.0; // [10.0, 22.0] Ring height (mm)
const bar = 3.0;
let plate = box_from_corners([-6.0, -12.5, 0], [6.0, 12.5, 1.5]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let base = cylinder([-ring_w / 2.0, 6.0, bar / 2.0], "X", bar / 2.0, ring_w);
let legs = cylinder([-ring_w / 2.0, 6.0, bar / 2.0], "Y", bar / 2.0, ring_h) + cylinder([ring_w / 2.0, 6.0, bar / 2.0], "Y", bar / 2.0, ring_h);
let arc = (cylinder([0, 6.0 + ring_h, -1.0], "Z", ring_w / 2.0 + bar / 2.0, bar + 2.0) - cylinder([0, 6.0 + ring_h, -2.0], "Z", ring_w / 2.0 - bar / 2.0, bar + 4.0) - box_from_corners([-ring_w, 0, -5.0], [ring_w, 6.0 + ring_h, 5.0])) & box_from_corners([-ring_w, 0, 0], [ring_w, 100.0, bar]);
let corners = sphere([-ring_w / 2.0, 6.0, bar / 2.0], bar / 2.0 + 0.1) + sphere([ring_w / 2.0, 6.0, bar / 2.0], bar / 2.0 + 0.1);
plate + base + legs + arc + corners - cylinder([0, -6.0, -1.0], "Z", 1.75, 4.0)
