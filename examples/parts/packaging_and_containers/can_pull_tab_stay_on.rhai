// Stay-on pull tab for a 202 beverage can end: 21 x 12 mm aluminium tab 0.5 mm thick with a 0.4 mm raised stiffening rim, 2.4 mm rivet hole near the nose and a 10 x 6 mm finger hole
let tab_length = 21.0; // [16.0, 28.0] Tab length (mm)
let tab_width = 12.0; // [9.0, 16.0] Tab width (mm)
let thickness = 0.5; // [0.3, 1.0] Sheet thickness (mm)
let rim_width = 0.9; // [0.5, 1.5] Rim width (mm)
let rivet_hole = 2.4; // [1.5, 3.5] Rivet hole diameter (mm)
let r = tab_width / 2.0;
let outline = sketch("XY")
    .move_to(-tab_length / 2.0 + r, -r)
    .hline_to(tab_length / 2.0 - 3.0)
    .arc_to(tab_length / 2.0, 0, tab_length / 2.0 - 3.0, r)
    .hline_to(-tab_length / 2.0 + r)
    .arc_to(-tab_length / 2.0, 0, -tab_length / 2.0 + r, -r)
    .close();
let plate = face(outline).extrude([0, 0, thickness]);
let rim = (face(outline) - face(outline.offset(-rim_width))).extrude([0, 0, thickness + 0.4]);
let tab = plate + rim;
// finger hole at the tail, with its own rim, and the rivet hole at the nose
let hole_c = -tab_length / 2.0 + r;
let finger = face(rect(4.0, 0.01).offset(3.0)).translate([hole_c, 0, 0]);
let finger_rim = (face(rect(4.0, 0.01).offset(3.0 + rim_width)) - face(rect(4.0, 0.01).offset(3.0))).translate([hole_c, 0, 0]).extrude([0, 0, thickness + 0.4]);
tab = (tab + finger_rim) - finger.translate([0, 0, -1.0]).extrude([0, 0, 3.0]);
tab - cylinder([tab_length / 2.0 - 4.5, 0, -1], "Z", rivet_hole / 2.0, 3.0)
