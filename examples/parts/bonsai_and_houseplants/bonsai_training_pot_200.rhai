// Bonsai training pot: 200 x 150 mm shallow rectangular pot 50 mm tall, 5 mm walls, 6 mm floor with two 20 mm drain holes, four 3 mm wire tie-down holes and four 8 mm feet
let length = 200.0; // [120.0, 300.0] Pot length (mm)
let height = 50.0; // [30.0, 80.0] Pot height (mm)
const width = 150.0;
const wall = 5.0;
let p = box_centered(length, width, height).translate([0, 0, height / 2.0 + 8.0]);
let p = p.fillet(6.0, p.edges("|Z"));
let p = p - box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 + 8.0 + 6.0]);
let feet = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { feet.push(box_centered(25.0, 20.0, 8.01).translate([sx * (length / 2.0 - 20.0), sy * (width / 2.0 - 18.0), 4.0])); } }
let holes = [cylinder([-length / 4.0, 0, 0], "Z", 10.0, 20.0), cylinder([length / 4.0, 0, 0], "Z", 10.0, 20.0)];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (length / 4.0 + 18.0), sy * 15.0, 0], "Z", 1.5, 20.0)); } }
p + fuse_all(feet) - fuse_all(holes)
