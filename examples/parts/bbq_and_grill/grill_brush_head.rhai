// Grill brush head: 120 x 45 x 15 mm block with 3 rows of 12 bristle tuft holes 4 mm 10 mm deep, 2 M5 handle holes
let length = 120.0; // [80.0, 160.0] Head length (mm)
let width = 45.0; // [30.0, 60.0] Head width (mm)
let height = 15.0; // [10.0, 25.0] Head thickness (mm)
let rows = 3; // [2, 5] Number of tuft rows
let cols = 12; // [6, 20] Tufts per row
let head = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let h = head.fillet(width / 2.0 - 5.0, head.edges("|Z"));
let tufts = [];
for i in 0..cols { for j in 0..rows { tufts.push(cylinder([-length / 2.0 + 10.0 + i.to_float() * (length - 20.0) / (cols - 1).to_float(), -width / 2.0 + 10.0 + j.to_float() * (width - 20.0) / (rows - 1).to_float(), -1], "Z", 2.0, 11.0)); } }
h - compound(tufts) - cylinder([-15.0, 0, height - 8.0], "Z", 2.5, 9.0) - cylinder([15.0, 0, height - 8.0], "Z", 2.5, 9.0)
