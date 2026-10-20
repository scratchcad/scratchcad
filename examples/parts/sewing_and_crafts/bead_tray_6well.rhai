// Bead sorting tray: 120 x 80 x 15 mm with 6 rounded wells 34 x 34 mm, 10 mm deep
let length = 120.0; // [80.0, 200.0] Length (mm)
let width = 80.0; // [60.0, 140.0] Width (mm)
let height = 15.0; // [10.0, 25.0] Height (mm)
let well = 34.0; // [20.0, 50.0] Well size (mm)
let tray = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let t = tray.fillet(6.0, tray.edges("|Z"));
let wells = [];
for i in 0..3 { for j in 0..2 {
    let w = box_centered(well, well, 20.0).translate([(i.to_float() - 1.0) * (well + 4.0), (j.to_float() - 0.5) * (well + 4.0), height]);
    wells.push(w.fillet(6.0, w.edges("|Z")));
} }
t - compound(wells).translate([0, 0, -10.0 + 2.0])
