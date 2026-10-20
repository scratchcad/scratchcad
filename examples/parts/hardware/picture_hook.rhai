// Brass picture hook: 3 mm wire hook 25 mm long swept on an arc, with a nail plate 10 x 20 mm and a 1.5 mm nail hole
let wire_d = 3.0; // [1.5, 5.0] Wire diameter (mm)
let hook_r = 6.0; // [3.0, 15.0] Hook radius (mm)
let plate_w = 10.0; // [6.0, 20.0] Plate width (mm)
let plate_h = 20.0; // [12.0, 40.0] Plate height (mm)
let plate = box_from_corners([-plate_w / 2.0, 0, 0], [plate_w / 2.0, 1.2, plate_h]).fillet(2.0, "|Y") - cylinder([0, -1, plate_h * 0.75], "Y", 0.8, 4.0).rotate_x(-30);
let path = wire([line([0, 0.6, 2.0], [0, hook_r, -hook_r * 0.4]), arc([0, hook_r, -hook_r * 0.4], [0, hook_r * 2.0, -hook_r * 1.4], [0, hook_r * 2.6, -hook_r * 0.2])]);
plate + circle([0, 0.6, 2.0], [0, hook_r - 0.6, -hook_r * 0.4 - 2.0], wire_d / 2.0).to_face().sweep(path)
