// Bed rail bracket: L-bracket holding a 25 mm assist-rail tube to a bed frame, 60 x 50 mm wall plate 6 mm thick with two 6.5 mm slotted holes, 40 mm tube saddle with a 25.4 mm bore and M6 set screw, 4 mm gusset
// # Plate
let plate_w = 60.0; // [45.0, 90.0] Plate width (mm)
let plate_h = 50.0; // [40.0, 80.0] Plate height (mm)
let thickness = 6.0; // [4.0, 10.0] Plate thickness (mm)
// # Tube
let tube = 25.4; // [19.0, 32.0] Rail tube diameter (mm)
let saddle_length = 40.0; // [25.0, 60.0] Saddle length (mm)
let ro = tube / 2.0 + 5.0;
let plate = box_from_corners([-plate_w / 2.0, 0, 0], [plate_w / 2.0, thickness, plate_h]).fillet(5.0, "|Y");
let saddle = cylinder([0, thickness - 0.5, plate_h / 2.0], "Y", ro, saddle_length + 0.5);
let gusset = polygon("YZ", [[thickness - 0.5, 2.0], [thickness + saddle_length * 0.8, plate_h / 2.0 - ro + 2.0], [thickness - 0.5, plate_h / 2.0]]).to_face().extrude([4.0, 0, 0]).translate([-2.0, 0, 0]);
let body = plate + saddle + gusset;
let bore = cylinder([0, -1.0, plate_h / 2.0], "Y", tube / 2.0, thickness + saddle_length + 2.0);
let set_screw = cylinder([0, thickness + saddle_length * 0.6, plate_h / 2.0], "Z", 2.5, ro + 1.0);
let slots = [];
for s in [-1.0, 1.0] {
    let x = s * (plate_w / 2.0 - 9.0);
    slots.push(fuse_all([cylinder([x, -1.0, plate_h * 0.3], "Y", 3.25, thickness + 2.0), cylinder([x, -1.0, plate_h * 0.7], "Y", 3.25, thickness + 2.0), box_from_corners([x - 3.25, -1.0, plate_h * 0.3], [x + 3.25, thickness + 1.0, plate_h * 0.7])]));
}
body - bore - set_screw - compound(slots)
