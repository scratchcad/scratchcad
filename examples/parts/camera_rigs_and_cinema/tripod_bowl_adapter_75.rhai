// 75 mm half-ball levelling adapter for a tripod bowl: 75 mm ball segment 28 mm tall, 3/8-16 tapped hole (8 mm core) 12 mm deep in the flat top, 60 mm flat 4 mm top flange, 10.5 mm bore for the M10 tie-down rod from underneath, stopping 2 mm short of the top hole
let bowl_d = 75.0; // [60.0, 150.0] Bowl size (mm)
let height = 28.0; // [20.0, 45.0] Ball segment height (mm)
let flange = 4.0; // [2.0, 8.0] Top flange thickness (mm)
let r = bowl_d / 2.0;
let ball = sphere([0, 0, r], r) & box_centered(bowl_d + 2.0, bowl_d + 2.0, height).translate([0, 0, height / 2.0]);
let ball = ball.translate([0, 0, -height]);
let top = cylinder([0, 0, 0], "Z", r * 0.8, flange);
let part = ball + top;
part - cylinder([0, 0, flange - 12.0], "Z", 4.0, 13.0) - cylinder([0, 0, -height - 1.0], "Z", 5.25, flange - 14.0 + height + 1.0)
