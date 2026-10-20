// Double coat hook: 40 x 60 mm wall plate 5 mm thick, upper hook 60 mm and lower hook 40 mm swept from 8 mm rod, 2 screw holes
let plate_w = 40.0; // [25.0, 80.0] Plate width (mm)
let plate_h = 60.0; // [40.0, 120.0] Plate height (mm)
let rod_d = 8.0; // [5.0, 14.0] Rod diameter (mm)
let plate = box_centered(plate_w, 5.0, plate_h).translate([0, 2.5, plate_h / 2.0]).fillet(6.0, "|Y");
let upper = circle([0, 4.0, plate_h * 0.6], "Y", rod_d / 2.0).to_face().sweep(wire([line([0, 4.0, plate_h * 0.6], [0, 40.0, plate_h * 0.75]), arc([0, 40.0, plate_h * 0.75], [0, 55.0, plate_h * 0.95], [0, 60.0, plate_h * 1.15])]));
let lower = circle([0, 4.0, plate_h * 0.25], "Y", rod_d / 2.0).to_face().sweep(wire([line([0, 4.0, plate_h * 0.25], [0, 30.0, plate_h * 0.25]), arc([0, 30.0, plate_h * 0.25], [0, 37.0, plate_h * 0.33], [0, 40.0, plate_h * 0.45])]));
let hook = fuse_all([plate, upper, lower, sphere([0, 60.0, plate_h * 1.15], rod_d * 0.6), sphere([0, 40.0, plate_h * 0.45], rod_d * 0.6)]);
hook - cylinder([0, -1, plate_h * 0.88], "Y", 2.25, 7.0) - cylinder([0, -1, plate_h * 0.1], "Y", 2.25, 7.0)
