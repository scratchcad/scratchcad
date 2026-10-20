// Wall can crusher plates: 330 ml can crusher base plate 120 x 90 x 8 mm with a 70 mm can cup 3 mm deep, four 6 mm screw holes and a 30 mm lever pivot boss bored 10 mm
let cup = 70.0; // [55.0, 90.0] Can cup diameter (mm)
let plate_l = 120.0; // [100.0, 160.0] Plate length (mm)
const t = 8.0;
let p = box_centered(plate_l, 90.0, t).translate([0, 0, t / 2.0]);
let p = p.fillet(6.0, p.edges("|Z"));
let boss = cylinder([0, 45.0 - 0.01, t + 10.0], "Y", 15.0, 20.0) + box_from_corners([-15.0, 45.0 - 0.01, 0], [15.0, 65.0, t + 10.0]);
let holes = [cylinder([0, 40.0, t + 10.0], "Y", 5.0, 30.0), cylinder([0, 0, t - 3.0], "Z", cup / 2.0, 4.0)];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (plate_l / 2.0 - 10.0), sy * 35.0, -1.0], "Z", 3.0, t + 2.0)); } }
p + boss - fuse_all(holes)
