// Aquarium suction cup clip for 12 mm tubing: 30 mm cup 8 mm tall, neck with a 12 mm C clip opening 9 mm
let tube = 12.0; // [4.0, 20.0] Tube diameter (mm)
let cup = (sphere([0, 0, -12.0], 18.0) - sphere([0, 0, -12.0], 16.5)) & box_centered(40.0, 40.0, 7.0).translate([0, 0, 3.5]);
let neck = cylinder([0, 0, 5.5], "Z", 3.0, 8.0);
let clip = (cylinder([-6.0, 0, 13.0 + tube / 2.0], "X", tube / 2.0 + 2.0, 12.0) - cylinder([-7.0, 0, 13.0 + tube / 2.0], "X", tube / 2.0, 14.0)) - box_centered(14.0, tube * 0.75, tube).translate([0, 0, 13.0 + tube + 2.0]);
fuse_all([cup, neck, clip])
