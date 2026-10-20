// Eccentric climbing hex (size 7 style): irregular hexagon 46 x 36 mm across, 34 mm tall with 6 degree tapered ends, two 6 mm sling holes 18 mm apart, 1 mm edge chamfers
let length = 46.0; // [25.0, 70.0] Length across the long faces (mm)
let width = 36.0; // [20.0, 55.0] Width across the short faces (mm)
let height = 34.0; // [18.0, 50.0] Height (mm)
let taper = 6.0; // [0.0, 12.0] End taper (degrees)
let sling_d = 6.0; // [4.0, 8.0] Sling hole diameter (mm)
let a = length / 2.0;
let b = width / 2.0;
// eccentric outline: the short sides are unequal so the hex cams in a crack
let pts = [[-a, -b * 0.15], [-a * 0.45, -b], [a * 0.6, -b], [a, b * 0.1], [a * 0.35, b], [-a * 0.55, b]];
let hex = polygon(pts).to_face().extrude([0, 0, height]);
let t = taper * PI() / 180.0;
let top_cut = box_centered(length * 3.0, width * 3.0, height).translate([0, 0, height * 1.5]).rotate([0, 0, height], "X", taper);
let bot_cut = box_centered(length * 3.0, width * 3.0, height).translate([0, 0, -height * 0.5]).rotate([0, 0, 0], "X", -taper);
hex = hex - top_cut - bot_cut;
hex = hex.chamfer(1.0, "|Z");
let sd = min(sling_d, height / 4.0);
for x in [-9.0, 9.0] { hex = hex - cylinder([x, -width, height / 2.0], "Y", sd / 2.0, 2.0 * width); }
hex
