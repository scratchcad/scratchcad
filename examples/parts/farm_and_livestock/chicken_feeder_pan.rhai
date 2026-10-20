// Hanging chicken feeder pan: 300 mm pan, 60 mm rim, 12 anti-waste fingers, center cone to spread feed
let diameter = 300.0; // [200.0, 400.0] Pan diameter (mm)
let rim = 60.0; // [40.0, 80.0] Rim height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let pan = cylinder(diameter / 2.0, rim) - cylinder([0, 0, wall], "Z", diameter / 2.0 - wall, rim);
let lip = cylinder([0, 0, rim - 10.0], "Z", diameter / 2.0 - wall + 0.01, 10.0) - cone(diameter / 2.0 - wall, diameter / 2.0 - 25.0, 10.0).translate([0, 0, rim - 10.0]);
let fingers = [];
for k in 0..12 { fingers.push(box_from_corners([diameter / 2.0 - 60.0, -1.0, wall - 0.01], [diameter / 2.0 - wall + 0.01, 1.0, rim - 15.0]).rotate_z(k.to_float() * 30.0)); }
let cone_ = cone(70.0, 15.0, 80.0).translate([0, 0, wall - 0.01]);
pan + lip + fuse_all(fingers) + cone_
