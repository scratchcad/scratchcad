// Panel bezel for an SS12D00 SPDT slide switch (8.5 x 3.6 x 3.5 mm body, 4 mm actuator travel 3 mm): 20 x 10 x 1.5 mm plate, 7.4 x 2.2 mm actuator slot, rear pocket 8.8 x 4 x 3.6 mm with 1 mm walls, 2 x M2 screw holes 15 mm apart
let plate_w = 20.0; // [16.0, 30.0] Plate width (mm)
let plate_h = 10.0; // [8.0, 16.0] Plate height (mm)
let thick = 1.5; // [1.0, 3.0] Plate thickness (mm)
let slot_l = 7.4; // [5.0, 9.0] Actuator slot length (mm)
let slot_w = 2.2; // [1.5, 3.0] Actuator slot width (mm)
let hole_spacing = 15.0; // [12.0, 25.0] Screw hole spacing (mm)
const body_l = 8.8;
const body_w = 4.0;
const body_h = 3.6;
let hs = max(hole_spacing, body_l + 2.0 + 4.0);
let pw = max(plate_w, hs + 5.0);
let ph = max(plate_h, body_w + 4.0);
let plate = box_centered(pw, ph, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(min(ph * 0.4, 3.0), plate.edges("|Z"));
let pocket = box_centered(body_l + 2.0, body_w + 2.0, body_h + 0.5).translate([0, 0, thick + body_h / 2.0 - 0.25]);
let body = plate + pocket;
let cavity = box_centered(body_l, body_w, body_h * 2.0).translate([0, 0, thick + body_h]);
let sl = min(slot_l, body_l - 0.8);
let slot = box_centered(sl, min(slot_w, body_w - 0.6), thick * 4.0);
body - cavity - slot - cylinder([-hs / 2.0, 0, -1], "Z", 1.1, thick + 2.0) - cylinder([hs / 2.0, 0, -1], "Z", 1.1, thick + 2.0)
