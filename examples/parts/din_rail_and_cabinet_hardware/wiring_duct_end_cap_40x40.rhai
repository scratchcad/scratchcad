// End cap for 40 x 40 mm slotted wiring duct: 2 mm end plate the size of the duct, 8 mm deep 1.2 mm plug rim that pushes inside the 1.6 mm duct walls, open at the top for the cover, with a 1 mm chamfer round the outside
let duct_width = 40.0; // [15.0, 100.0] Duct width (mm)
let duct_height = 40.0; // [25.0, 100.0] Duct height (mm)
let plug_depth = 8.0; // [4.0, 15.0] Plug depth (mm)
const plate = 2.0;
const duct_wall = 1.6;
const rim = 1.2;
let w_in = duct_width - 2.0 * duct_wall - 0.3;
let h_in = duct_height - duct_wall - 0.3;
let face_plate = box_from_corners([-duct_width / 2.0, 0, 0], [duct_width / 2.0, plate, duct_height]);
let face_plate = face_plate.chamfer(0.8, face_plate.edges("<Y"));
let plug = box_from_corners([-w_in / 2.0, plate - 0.5, duct_wall + 0.15], [w_in / 2.0, plate + plug_depth, duct_height - 2.0])
    - box_from_corners([-w_in / 2.0 + rim, plate, duct_wall + 0.15 + rim], [w_in / 2.0 - rim, plate + plug_depth + 1.0, duct_height]);
face_plate + plug
