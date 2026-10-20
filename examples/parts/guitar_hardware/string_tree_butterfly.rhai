// Butterfly string tree: 14 x 6 mm wing 3 mm thick on a 5 mm spacer 4 mm tall with a 2.2 mm screw hole; the strings run under the wing
let width = 14.0; // [10.0, 18.0] Tree width (mm)
let spacer = 4.0; // [2.0, 8.0] Spacer height (mm)
const t = 3.0;
let wing = box_centered(width, 6.0, t).translate([0, 0, spacer + t / 2.0]);
let wing = wing.fillet(2.0, wing.edges("|Z"));
let sp = cylinder([0, 0, 0], "Z", 2.5, spacer + 0.01);
wing + sp - cylinder([0, 0, -1.0], "Z", 1.1, spacer + t + 2.0)
