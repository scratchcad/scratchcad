// Zipper pull tab for a #5 slider: 28 mm long, 7 mm wide at the top flaring to a 10 mm round end, 1.6 mm thick, 4 x 2.2 mm slot for the slider bridge and a 3 mm lanyard hole
let tab_length = 28.0; // [18.0, 40.0] Tab length (mm)
let top_width = 7.0; // [5.0, 10.0] Top width (mm)
let end_width = 10.0; // [6.0, 16.0] Round end width (mm)
let thickness = 1.6; // [1.0, 3.0] Thickness (mm)
let slot_length = 4.0; // [2.5, 6.0] Bridge slot length (mm)
let lanyard_hole = 3.0; // [0.0, 5.0] Lanyard hole diameter (mm)
let re = end_width / 2.0;
let tw = min(top_width, end_width);
let outline = sketch("XY")
    .move_to(-tw / 2.0, 0)
    .line_to(tw / 2.0, 0)
    .line_to(re, -(tab_length - re))
    .arc_to(0, -tab_length, -re, -(tab_length - re))
    .close();
let tab = outline.to_face().extrude([0, 0, thickness]).fillet(1.2, "|Z and >Y");
let sw = min(slot_length, tw - 2.0);
let slot = face(rect(sw - 2.2 + 0.01, 0.01).offset(1.1)).extrude([0, 0, thickness + 2.0]).translate([0, -2.6, -1.0]);
tab = tab - slot;
// shallow thumb recess on the face
let recess = face(rect(0.01, tab_length * 0.3).offset(tw * 0.28)).extrude([0, 0, 1.0]).translate([0, -tab_length * 0.48, thickness - 0.4]);
tab = tab - recess;
if lanyard_hole > 0.0 {
    tab = tab - cylinder([0, -(tab_length - re) - re * 0.45 + 0.3, -1.0], "Z", min(lanyard_hole, re * 0.6) / 2.0, thickness + 2.0);
}
tab
