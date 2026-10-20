// Elastic shoelace lock: no-tie lace lock for 3 to 4 mm round elastic laces, 22 x 14 x 9 mm oval body with two 4.2 mm lace channels, sprung cam slot 2.5 mm wide and a 6 mm pull tab, lets users with one hand tighten shoes
// # Body
let length = 22.0; // [16.0, 30.0] Body length (mm)
let width = 14.0; // [10.0, 20.0] Body width (mm)
let height = 9.0; // [6.0, 14.0] Body height (mm)
// # Lace
let lace = 4.2; // [3.0, 5.5] Lace channel diameter (mm)
let cam_slot = 2.5; // [1.5, 4.0] Cam slot width (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(width / 2.0 - 0.5, "|Z").fillet(1.5, ">Z or <Z");
let channels = [cylinder([-length / 2.0 + lace / 2.0 + 2.5, 0, -1.0], "Z", lace / 2.0, height + 2.0), cylinder([length / 2.0 - lace / 2.0 - 2.5, 0, -1.0], "Z", lace / 2.0, height + 2.0)];
let cam = box_from_corners([-length / 2.0 + lace + 2.0, -cam_slot / 2.0, -1.0], [length / 2.0 - lace - 2.0, cam_slot / 2.0, height + 1.0]);
let side_slot = box_from_corners([-cam_slot / 2.0, -width, height * 0.3], [cam_slot / 2.0, 0, height * 0.7]);
let tab = box_from_corners([-3.0, width / 2.0 - 1.0, 0], [3.0, width / 2.0 + 6.0, 2.5]).fillet(2.5, "|Z and >Y") - cylinder([0, width / 2.0 + 3.0, -1.0], "Z", 1.5, 5.0);
body - compound(channels) - cam - side_slot + tab
