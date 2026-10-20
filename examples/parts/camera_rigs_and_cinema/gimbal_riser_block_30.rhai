// Gimbal camera riser block 30 mm tall: 60 x 38 mm Arca-Swiss dovetail base (38 mm wide, 45 degree, 4 mm deep) under a 50 x 38 mm top with a 6.5 x 30 mm 1/4-20 slot, hollowed with a 30 x 24 mm pocket from below, 1.5 mm top chamfers
let height = 30.0; // [15.0, 60.0] Riser height (mm)
let length = 60.0; // [40.0, 120.0] Riser length (mm)
let slot_len = 30.0; // [10.0, 30.0] Screw slot length (mm)
const width = 38.0;
let profile = polygon([[0, -width / 2.0 + 4.0, 0], [0, width / 2.0 - 4.0, 0], [0, width / 2.0, 4.0], [0, width / 2.0, height], [0, -width / 2.0, height], [0, -width / 2.0, 4.0]]);
let body = face(profile).extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let body = body.chamfer(1.5, body.edges(">Z"));
let pocket = box_centered(length - 30.0, 24.0, height - 6.0).translate([0, 0, (height - 6.0) / 2.0 - 1.0]);
let sl = min(slot_len, length - 30.0) - 6.5;
let slot = box_centered(sl, 6.5, 10.0).translate([0, 0, height - 3.0])
    + cylinder([-sl / 2.0, 0, height - 8.0], "Z", 3.25, 10.0) + cylinder([sl / 2.0, 0, height - 8.0], "Z", 3.25, 10.0);
let base_hole = cylinder([0, 0, -1.0], "Z", 3.25, height);
body - pocket - slot - base_hole
