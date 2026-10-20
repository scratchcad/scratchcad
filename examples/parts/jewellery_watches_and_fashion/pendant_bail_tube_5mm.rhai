// Pendant bail for a 5 mm chain or cord: rounded loop 7 x 9 mm outside, 3 x 5 mm opening, 2.5 mm thick, with a 1.2 mm thick tab and a 1.5 mm jump-ring hole below
let opening_width = 3.0; // [2.0, 4.8] Opening width (mm)
let opening_height = 5.0; // [3.0, 8.0] Opening height (mm)
let wall = 2.0; // [1.0, 3.0] Loop wall (mm)
let thickness = 2.5; // [1.5, 4.0] Loop thickness (mm)
let tab_length = 5.0; // [3.0, 8.0] Tab length (mm)
let hole_diameter = 1.5; // [0.8, 2.5] Jump-ring hole diameter (mm)
// loop in the XZ plane, centred at z = 0, thickness along Y
let ro_corner = (opening_width / 2.0) + wall;
let outer = face(rect("XZ", 0.01, opening_height - opening_width + 0.01).offset(ro_corner));
let inner = face(rect("XZ", 0.01, opening_height - opening_width + 0.01).offset(opening_width / 2.0));
let loop_ring = (outer - inner).extrude([0, thickness, 0]).translate([0, -thickness / 2.0, 0]);
let z_bottom = -(opening_height / 2.0 + wall);
let tab = box_centered(opening_width + 1.0, 1.2, tab_length + 1.0).translate([0, 0, z_bottom - tab_length / 2.0 + 0.5]).fillet(0.5, "|Y and <Z");
let bail = loop_ring + tab;
bail - cylinder([0, -2, z_bottom - tab_length + hole_diameter / 2.0 + 0.8], "Y", hole_diameter / 2.0, 4)
