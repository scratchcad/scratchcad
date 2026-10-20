// Sheffield cycle stand base plate: 150 x 100 x 8 mm plate welded under a 48.3 mm leg, with a 52 mm locating collar 20 mm tall and four 14 mm anchor bolt holes on 120 x 70 mm
let leg = 48.3; // [42.4, 60.3] Leg tube OD (mm)
let plate_l = 150.0; // [130.0, 200.0] Plate length (mm)
const t = 8.0;
let p = box_centered(plate_l, 100.0, t).translate([0, 0, t / 2.0]);
let p = p.fillet(10.0, p.edges("|Z"));
let collar = cylinder([0, 0, t - 0.01], "Z", leg / 2.0 + 4.0, 20.0) - cylinder([0, 0, t], "Z", leg / 2.0 + 0.5, 21.0);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 60.0, sy * 35.0, -1.0], "Z", 7.0, t + 2.0)); } }
p + collar - fuse_all(holes)
