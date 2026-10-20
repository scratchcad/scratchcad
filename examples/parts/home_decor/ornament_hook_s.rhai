// Christmas ornament S-hook: 1.5 mm wire, 40 mm tall, 10 mm upper and 8 mm lower hooks
let wire = 1.5; // [1.0, 2.5] Wire diameter (mm)
let length = 40.0; // [25.0, 60.0] Overall length (mm)
let r = wire / 2.0;
const top_r = 5.0;
const bot_r = 4.0;
let s = cylinder([0, 0, bot_r], "Z", r, length - top_r - bot_r);
let top = (cylinder([-top_r, -r, length - top_r], "Y", top_r + r, wire) - cylinder([-top_r, -wire, length - top_r], "Y", top_r - r, wire * 2.0)) & box_from_corners([-20, -5, length - top_r], [20, 5, length + 5.0]);
let top2 = (cylinder([-top_r, -r, length - top_r], "Y", top_r + r, wire) - cylinder([-top_r, -wire, length - top_r], "Y", top_r - r, wire * 2.0)) & box_from_corners([-30, -5, length - top_r - 3.0], [-top_r, 5, length - top_r + 0.01]);
let bot = (cylinder([bot_r, -r, bot_r], "Y", bot_r + r, wire) - cylinder([bot_r, -wire, bot_r], "Y", bot_r - r, wire * 2.0)) & box_from_corners([-20, -5, -5], [20, 5, bot_r]);
s + top + top2 + bot
