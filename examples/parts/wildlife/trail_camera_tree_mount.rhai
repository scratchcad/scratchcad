// Trail camera tree mount: 1/4-20 stud on a 40 mm tilt head, 60 x 40 mm tree plate with 2 strap slots 26 x 4 mm and 4 gripping teeth
let plate_l = 60.0; // [45.0, 90.0] Plate length (mm)
let plate_w = 40.0; // [30.0, 60.0] Plate width (mm)
let plate = box_centered(plate_l, plate_w, 6.0).translate([0, 0, 3.0]);
let p = plate.fillet(6.0, plate.edges("|Z"));
let slots = box_centered(4.0, 26.0, 20.0).translate([-plate_l / 2.0 + 8.0, 0, 0]) + box_centered(4.0, 26.0, 20.0).translate([plate_l / 2.0 - 8.0, 0, 0]);
let teeth = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { teeth.push(cone(2.0, 0.3, 3.0).rotate_x(180.0).translate([sx * 15.0, sy * (plate_w / 2.0 - 6.0), 0.01])); } }
let post = cylinder([0, 0, 5.99], "Z", 8.0, 20.0);
let stud = cylinder([0, 0, 25.98], "Z", 3.15, 9.0);
p - slots + fuse_all(teeth) + post + stud
