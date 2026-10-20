// 50 mm swivel caster: 60 x 60 x 3 mm top plate with four holes, swivel race, 3 mm steel fork with 22 mm offset, 20 mm wide wheel on an 8 mm axle
let wheel_d = 50.0; // [30.0, 100.0] Wheel diameter (mm)
let wr = wheel_d / 2.0;
let az = -(wr + 18.0);
let plate = box_centered(60.0, 60.0, 3.0).translate([0, 0, -1.5]).fillet(5.0, "|Z");
for x in [-22.0, 22.0] { for y in [-22.0, 22.0] { plate -= cylinder([x, y, -4], "Z", 3.0, 5.0); } }
let race = cylinder([0, 0, -11.0], "Z", 20.0, 8.0);
let fork = box_from_corners([-14.0, -14.0, -14.0], [14.0, 14.0, -11.0]);
for s in [-1.0, 1.0] { fork += polygon([[-14, 0, -14], [14, 0, -14], [22.0 + 7.0, 0, az], [22.0 - 7.0, 0, az - 4.0]]).to_face().extrude([0, 3.0, 0]).translate([0, s * 12.5 - 1.5, 0]); }
let axle = cylinder([22.0, -14.0, az], "Y", 4.0, 28.0);
let wheel = cylinder([22.0, -10.0, az], "Y", wr, 20.0).fillet(3.0, "%CIRCLE") - cylinder([22.0, -11.0, az], "Y", 4.2, 22.0);
compound([fuse_all([plate, race, fork, axle]), wheel])
