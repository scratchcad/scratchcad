// Wheelchair push-rim mounting tab: 30 x 12 mm plate 3 mm thick, 5.3 mm hole for the wheel rim, 18 mm standoff 9 mm across with an M5 bore for the push rim
let plate_length = 30.0; // [20.0, 45.0] Plate length (mm)
let plate_width = 12.0; // [8.0, 18.0] Plate width (mm)
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
let standoff = 18.0; // [8.0, 30.0] Standoff length (mm)
let standoff_diameter = 9.0; // [7.0, 14.0] Standoff diameter (mm)
let hw = plate_width / 2.0;
let plate = box_from_corners([0, -hw, 0], [plate_length, hw, thickness]).fillet(hw - 0.1, "|Z");
let x2 = plate_length - hw;
let post = cylinder([x2, 0, thickness - 0.1], "Z", standoff_diameter / 2.0, standoff + 0.1).chamfer(0.6, ">Z");
let gusset = polygon([[x2 - standoff_diameter / 2.0 - 4.0, 0, thickness - 0.1], [x2, 0, thickness - 0.1], [x2, 0, thickness + standoff * 0.5]]).to_face()
    .extrude([0, 2.0, 0]).translate([0, -1.0, 0]);
let tab = fuse_all([plate, post, gusset]);
tab -= cylinder([hw, 0, -1.0], "Z", 2.65, thickness + 2.0);
tab - cylinder([x2, 0, -1.0], "Z", 2.1, standoff + thickness + 2.0)
