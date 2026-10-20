// Examination couch paper roll end bracket: 60 x 85 mm plate 5 mm thick with 8 mm rounded corners, a 26 mm wide open-top U slot 40 mm deep for the roll spindle and two 5.5 mm holes for M5 bolts into the couch frame
let spindle = 26.0; // [16.0, 34.0] Spindle diameter (mm)
let slot_depth = 40.0; // [25.0, 50.0] Slot depth (mm)
let width = 60.0; // [50.0, 80.0] Bracket width (mm)
const height = 85.0;
const t = 5.0;
let p = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height]);
p = p.fillet(8.0, p.edges("|Y"));
let slot = box_from_corners([-spindle / 2.0, -1.0, height - slot_depth + spindle / 2.0], [spindle / 2.0, t + 1.0, height + 1.0]) + cylinder([0, -1.0, height - slot_depth + spindle / 2.0], "Y", spindle / 2.0, t + 2.0);
p - slot - cylinder([-width / 2.0 + 12.0, -1.0, 15.0], "Y", 2.75, t + 2.0) - cylinder([width / 2.0 - 12.0, -1.0, 15.0], "Y", 2.75, t + 2.0)
