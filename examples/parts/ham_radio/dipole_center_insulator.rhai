// HF dipole centre insulator: 100 x 40 x 10 mm plate, SO-239 hole 16 mm with 4 x 3.2 mm holes on 18.3 mm, 2 wire strain holes, rope hole
let length = 100.0; // [70.0, 150.0] Plate length (mm)
let height = 40.0; // [30.0, 60.0] Plate height (mm)
let t = 10.0; // [6.0, 15.0] Thickness (mm)
let plate = box_centered(length, height, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(8.0, plate.edges("|Z"));
let holes = [cylinder([0, -4.0, -1], "Z", 8.0, t + 2.0)];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 9.15, -4.0 + sy * 9.15, -1], "Z", 1.6, t + 2.0)); } }
holes.push(cylinder([-length / 2.0 + 8.0, -6.0, -1], "Z", 2.5, t + 2.0));
holes.push(cylinder([length / 2.0 - 8.0, -6.0, -1], "Z", 2.5, t + 2.0));
holes.push(cylinder([0, height / 2.0 - 6.0, -1], "Z", 3.5, t + 2.0));
p - compound(holes)
