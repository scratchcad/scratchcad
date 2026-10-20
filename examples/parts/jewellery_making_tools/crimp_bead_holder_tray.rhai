// Jewellery findings tray: 6 round wells 20 mm 8 mm deep with sloped bottoms in a 100 x 70 x 12 mm block
let well = 20.0; // [14.0, 26.0] Well diameter (mm)
let depth = 8.0; // [5.0, 12.0] Well depth (mm)
let block = box_centered(100.0, 70.0, 12.0).translate([0, 0, 6.0]);
let b = block.fillet(6.0, block.edges("|Z"));
let wells = [];
for i in 0..3 { for j in 0..2 { wells.push(cone(2.0, well / 2.0, depth).translate([(i.to_float() - 1.0) * 30.0, (j.to_float() - 0.5) * 30.0, 12.0 - depth]) + cylinder([(i.to_float() - 1.0) * 30.0, (j.to_float() - 0.5) * 30.0, 11.99], "Z", well / 2.0, 1.0)); } }
b - compound(wells)
