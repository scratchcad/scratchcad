// Manfrotto 501PL-style sliding quick-release plate: 90 mm long, 52 mm wide at the top tapering at 45 degrees to 42 mm underneath, 10 mm thick, 6 mm rounded ends, 1/4-20 clearance slot 6.5 x 40 mm and a 3/8-16 clearance hole (9.8 mm), 1 mm deep 70 x 30 mm recess for the rubber pad
let length = 90.0; // [70.0, 120.0] Plate length (mm)
let width = 52.0; // [44.0, 60.0] Top width (mm)
let thickness = 10.0; // [8.0, 14.0] Plate thickness (mm)
let slot_len = 40.0; // [20.0, 50.0] Screw slot length (mm)
const bevel = 5.0;
let a = width / 2.0;
let profile = polygon([[0, -a + bevel, 0], [0, a - bevel, 0], [0, a, bevel], [0, a, thickness], [0, -a, thickness], [0, -a, bevel]]);
let plate = face(profile).extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let plate = plate & box_centered(length, width, 3.0 * thickness).fillet(6.0, "|Z");
let sl = min(slot_len, length - 30.0) - 6.5;
let slot = box_centered(sl, 6.5, thickness + 2.0).translate([-6.0, 0, thickness / 2.0])
    + cylinder([-6.0 - sl / 2.0, 0, -1.0], "Z", 3.25, thickness + 2.0) + cylinder([-6.0 + sl / 2.0, 0, -1.0], "Z", 3.25, thickness + 2.0);
let big = cylinder([length / 2.0 - 12.0, 0, -1.0], "Z", 4.9, thickness + 2.0);
let pad = box_centered(length - 20.0, width - 22.0, 2.0).translate([0, 0, thickness]);
plate - slot - big - pad
