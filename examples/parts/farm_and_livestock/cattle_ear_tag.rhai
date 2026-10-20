// Cattle ear tag, large panel: 75 x 58 mm female panel 1.6 mm, 14 mm neck, 10 mm stud housing
let width = 58.0; // [40.0, 80.0] Panel width (mm)
let height = 75.0; // [50.0, 100.0] Panel height (mm)
let t = 1.6; // [1.0, 2.5] Panel thickness (mm)
let panel = polygon([[-width / 2.0, 0], [width / 2.0, 0], [width / 2.0, height - 20.0], [7.0, height - 8.0], [-7.0, height - 8.0], [-width / 2.0, height - 20.0]]).to_face().extrude([0, 0, t]);
let p = panel.fillet(6.0, panel.edges("|Z"));
let neck = box_from_corners([-7.0, height - 8.01, 0], [7.0, height + 4.0, t]);
let housing = cylinder([0, height + 4.0, 0], "Z", 7.0, 6.0) - cylinder([0, height + 4.0, 1.0], "Z", 3.0, 6.0);
p + neck + housing
