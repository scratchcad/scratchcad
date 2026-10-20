// Wall leash hook with bowl: 80 x 40 mm plate 5 mm, 30 mm upturned hook 8 mm, 2 countersunk holes
let height = 80.0; // [60.0, 120.0] Plate height (mm)
let width = 40.0; // [30.0, 60.0] Plate width (mm)
let t = 5.0; // [3.0, 8.0] Plate thickness (mm)
let plate = box_centered(width, t, height).translate([0, t / 2.0, height / 2.0]);
let p = plate.fillet(width / 2.0 - 1.0, plate.edges("|Y"));
let arm = cylinder([0, t - 0.01, 18.0], "Y", 4.0, 30.0) + sphere([0, t + 30.0, 18.0], 4.4) + cylinder([0, t + 30.0, 18.0], "Z", 4.0, 15.0) + sphere([0, t + 30.0, 33.0], 4.4);
p + arm - cylinder([0, -1, height - 15.0], "Y", 2.0, t + 2.0) - cone(2.0, 4.0, 2.0).rotate_x(-90.0).translate([0, t - 1.99, height - 15.0])
