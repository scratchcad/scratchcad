// Hard hat accessory slot clip: 20 x 2.5 mm blade 30 mm long for the universal 22 x 3 mm side slot, 3 mm barb, 25 x 20 mm mounting plate 4 mm with an M5 hole
let blade_width = 20.0; // [15.0, 22.0] Blade width (mm)
let blade_thickness = 2.5; // [1.8, 3.0] Blade thickness (mm)
let blade_length = 30.0; // [20.0, 40.0] Blade length (mm)
let plate_thickness = 4.0; // [3.0, 6.0] Mounting plate thickness (mm)
const barb = 1.2;
let blade = box_from_corners([-blade_width / 2.0, 0, 0], [blade_width / 2.0, blade_thickness, blade_length]);
// a ramped barb near the tip so the clip snaps behind the slot lip
let barb_profile = polygon("YZ", [[blade_thickness, blade_length - 14.0], [blade_thickness + barb, blade_length - 10.0], [blade_thickness, blade_length - 4.0]]);
let barb_body = barb_profile.extrude([blade_width - 4.0, 0, 0]).translate([-blade_width / 2.0 + 2.0, 0, 0]);
let plate = box_from_corners([-12.5, -plate_thickness, -2.0], [12.5, 0.01, 22.0]);
let p = plate.fillet(3.0, plate.edges("|Y"));
let hole = cylinder([0, -plate_thickness - 1.0, 10.0], "Y", 2.75, plate_thickness + 2.0);
(p + blade + barb_body) - hole
