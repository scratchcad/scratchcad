// Raw water strainer wing cap: 75 mm cap 18 mm tall over a 70 mm bowl neck (thread shown as a plain bore), 4 mm top, 2.5 x 2 mm O-ring groove in the underside of the top, and a 60 x 10 mm wing grip 12 mm tall across the top with 2 mm rounded ends
let neck_d = 70.0; // [40.0, 90.0] Bowl neck diameter (mm)
let cap_h = 18.0; // [12.0, 25.0] Cap height (mm)
let wing_h = 12.0; // [8.0, 20.0] Wing height (mm)
const top_t = 4.0;
let ri = neck_d / 2.0 + 0.3;
let ro = ri + 2.5;
let cap = cylinder([0, 0, 0], "Z", ro, cap_h);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let ww = min(60.0, 2.0 * ro - 15.0);
let wing = box_centered(ww, 10.0, wing_h + 1.0).translate([0, 0, cap_h + wing_h / 2.0 - 0.5]);
let wing = wing.fillet(2.0, wing.edges("|Y and >Z"));
let body = cap + wing;
let groove = cylinder([0, 0, cap_h - top_t - 1.0], "Z", ri - 1.0, 3.0) - cylinder([0, 0, cap_h - top_t - 2.0], "Z", ri - 3.5, 5.0);
body - cylinder([0, 0, -1.0], "Z", ri, cap_h - top_t + 1.0) - groove
