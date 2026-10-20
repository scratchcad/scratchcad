// First aid box latch: 40 x 22 mm swing latch 3 mm thick with a 6 mm hinge knuckle (3 mm pin), 4 mm hook lip and a 12 mm finger tab
let length = 40.0; // [30.0, 55.0] Latch length (mm)
let width = 22.0; // [15.0, 30.0] Latch width (mm)
let thickness = 3.0; // [2.0, 4.0] Thickness (mm)
let pin = 3.0; // [2.0, 4.0] Hinge pin diameter (mm)
let knuckle_d = pin + 3.0;
let leaf = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let knuckle = cylinder([0, -width / 2.0, knuckle_d / 2.0], "Y", knuckle_d / 2.0, width);
let hook = box_from_corners([length - thickness, -width / 2.0, -4.0], [length, width / 2.0, 0.01]);
let catch_lip = polygon("XZ", [[length - thickness + 0.01, -4.0], [length - thickness - 1.5, -4.0], [length - thickness + 0.01, -2.0]]).to_face().extrude([0, -width, 0]).translate([0, width / 2.0, 0]);
let tab = box_from_corners([length - 0.01, -6.0, 0], [length + 12.0, 6.0, thickness]);
let t = tab.fillet(4.0, tab.edges("|Z and >X"));
(leaf + knuckle + hook + catch_lip + t) - cylinder([0, -width, knuckle_d / 2.0], "Y", pin / 2.0, width * 2.0)
