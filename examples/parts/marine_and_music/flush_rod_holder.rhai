// Flush-mount fishing rod holder, 15 deg: 60 x 100 mm oval top flange, 46 mm tube 230 mm long, cross pin slot, drain cap
let len = 230.0; // [150.0, 300.0] Tube length (mm)
let tilt = 15.0; // [0.0, 30.0] Tilt (deg)
let tube = cylinder([0, 0, -len], "Z", 23.0, len) - cylinder([0, 0, -len + 3.0], "Z", 21.0, len) - box_centered(50.0, 4.0, 12.0).translate([0, 0, -18.0]);
tube = tube.rotate_x(tilt);
let flange = (cylinder([0, -20.0, 0], "Z", 30.0, 4.0) + cylinder([0, 20.0, 0], "Z", 30.0, 4.0) + box_centered(60.0, 40.0, 4.0).translate([0, 0, 2.0])).chamfer(1.5, ">Z");
let hole = cylinder([0, 0, -len], "Z", 21.0, len + 10.0).rotate_x(tilt);
(flange + tube) - (hole - cylinder([0, 0, -len - 10.0], "Z", 30.0, len - 1.0 + 10.0).rotate_x(tilt))
