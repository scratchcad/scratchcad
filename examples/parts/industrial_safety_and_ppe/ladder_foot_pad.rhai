// Ladder foot pad: rubber shoe for a 75 x 25 mm aluminium stile, 90 x 40 mm sole 10 mm thick with six 3 mm deep tread grooves, 25 mm tall sleeve with 2.5 mm walls and a 6 mm rivet hole
let stile_width = 75.0; // [50.0, 100.0] Stile width (mm)
let stile_depth = 25.0; // [20.0, 40.0] Stile depth (mm)
let sole = 10.0; // [6.0, 15.0] Sole thickness (mm)
let sleeve = 25.0; // [15.0, 40.0] Sleeve height (mm)
let wall = 2.5; // [2.0, 4.0] Sleeve wall (mm)
let sw = stile_width + 15.0;
let sd = stile_depth + 15.0;
let s = box_centered(sw, sd, sole).translate([0, 0, sole / 2.0]);
let base = s.fillet(5.0, s.edges("|Z"));
let sl = box_centered(stile_width + 2.0 * wall, stile_depth + 2.0 * wall, sleeve).translate([0, 0, sole + sleeve / 2.0 - 0.01]);
let socket = box_centered(stile_width, stile_depth, sleeve + 1.0).translate([0, 0, sole + sleeve / 2.0 + 3.0]);
let grooves = [];
for i in 0..6 { grooves.push(box_centered(4.0, sd + 2.0, 6.0).translate([-sw / 2.0 + 10.0 + i.to_float() * (sw - 20.0) / 5.0, 0, 0])); }
(base + sl) - socket - compound(grooves) - cylinder([0, -sd, sole + sleeve * 0.6], "Y", 3.0, sd * 2.0)
