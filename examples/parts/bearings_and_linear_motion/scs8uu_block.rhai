// SCS8UU linear bearing block for 8 mm shaft: 34 x 30 x 22 mm aluminium housing, 4 M4 holes 24 x 18
let length = 30.0; // [20.0, 50.0] Length along the shaft (mm)
let width = 34.0; // [28.0, 50.0] Width (mm)
let height = 22.0; // [16.0, 35.0] Height (mm)
let shaft_h = 11.0; // [8.0, 18.0] Shaft center height (mm)
let bore = 15.0; // [10.0, 21.0] Bearing bore (mm)
let block = box_centered(width, length, height).translate([0, 0, height / 2.0]);
block = block - cylinder([0, -length, shaft_h], "Y", bore / 2.0, length * 2.0);
for sx in [-1, 1] { for sy in [-1, 1] { block -= cylinder([sx * 12.0, sy * 9.0, height - 8.0], "Z", 1.65, 10.0); } }
block = block - box_centered(width - 14.0, length + 2.0, 3.0).translate([0, 0, 0]);
block.fillet(1.0, "|Y and >Z")
