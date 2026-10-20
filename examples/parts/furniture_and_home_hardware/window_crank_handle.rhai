// Casement window crank handle: 18 mm hub 20 mm tall with a 7 mm spline bore and set screw, 60 mm tapered arm, 12 mm spinning knob
let reach = 60.0; // [40.0, 90.0] Crank radius (mm)
let hub = cylinder(9.0, 20.0);
let arm = polygon([[0, -7], [reach, -5], [reach, 5], [0, 7]]).to_face().extrude(6.0).translate([0, 0, 14.0]);
let knob = cylinder([reach, 0, 20.0], "Z", 6.0, 20.0).fillet(2.0, ">Z");
let h = fuse_all([hub, arm, knob, cylinder([reach, 0, 14.0], "Z", 5.0, 6.0)]);
h - cylinder([0, 0, -1], "Z", 3.5, 16.0) - cylinder([-10.0, 0, 6.0], "X", 1.5, 10.0)
