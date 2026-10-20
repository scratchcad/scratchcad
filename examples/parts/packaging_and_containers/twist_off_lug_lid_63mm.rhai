// Twist-off (TO) lug lid for a 63 mm glass jar: 66 mm steel shell 0.5 mm thick, 9 mm skirt with a curled edge, four lugs, plastisol gasket ring and a 25 mm vacuum safety button
let lid_diameter = 66.0; // [40.0, 90.0] Lid diameter (mm)
let skirt_height = 9.0; // [6.0, 12.0] Skirt height (mm)
let sheet = 0.5; // [0.3, 0.8] Steel thickness (mm)
let lugs = 4; // [3, 6] Number of lugs
let button_diameter = 25.0; // [10.0, 40.0] Safety button diameter (mm)
let ro = lid_diameter / 2.0;
let shell = cylinder(ro, skirt_height).fillet(1.5, ">Z") - cylinder([0, 0, -1], "Z", ro - sheet, skirt_height + 1.0 - sheet).fillet(1.5 - sheet, ">Z");
// curled bottom edge
let curl = torus(ro - sheet / 2.0 + 0.1, 0.6).translate([0, 0, 0.6]);
let lid = shell + curl;
// gasket under the panel
let gasket = cylinder([0, 0, skirt_height - sheet - 1.2], "Z", ro - sheet + 0.05, 1.25) - cylinder([0, 0, skirt_height - 3.0], "Z", ro - 5.0, 3.0);
lid = lid + gasket;
// lugs: inward tabs at the bottom of the skirt
let tabs = [];
for i in 0..lugs {
    tabs.push(box_from_corners([ro - 2.2, -3.0, 0], [ro - 0.2, 3.0, 1.2]).rotate_z(i.to_float() * 360.0 / lugs.to_float()));
}
lid = fuse_all([lid] + tabs);
// safety button: a shallow raised dome in the panel
let rb = min(button_diameter / 2.0, ro - 6.0);
const rise = 0.6;
let big_r = (rb * rb + rise * rise) / (2.0 * rise);
let dome = sphere([0, 0, skirt_height + rise - big_r], big_r) - sphere([0, 0, skirt_height + rise - big_r], big_r - sheet);
dome = dome & cylinder([0, 0, skirt_height - sheet - 0.01], "Z", rb, rise + sheet + 1.0);
let hole = cylinder([0, 0, skirt_height - 1.0], "Z", rb - 0.01, 2.0) & sphere([0, 0, skirt_height + rise - big_r], big_r - sheet);
(lid - hole) + dome
