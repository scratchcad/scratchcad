// Window cleaner's squeegee belt holster: a 3 mm open-ended U channel 40 mm wide inside, 25 mm deep and 70 mm tall that takes a squeegee handle, with a 55 mm belt loop 5 mm deep for a 50 mm belt on the back, a 20 mm slot up the front wall, and a 6 mm drain hole through the 8 mm base
let channel_w = 40.0; // [25.0, 60.0] Channel width (mm)
let channel_d = 25.0; // [15.0, 40.0] Channel depth (mm)
let height = 70.0; // [50.0, 110.0] Holster height (mm)
let belt_w = 50.0; // [30.0, 60.0] Belt width (mm)
const t = 3.0;
let ow = channel_w + 2.0 * t;
let od = channel_d + 2.0 * t;
let outer = box_from_corners([-ow / 2.0, 0, 0], [ow / 2.0, od, height]);
let outer = outer.fillet(3.0, outer.edges("|Z and >Y"));
let inner = box_from_corners([-channel_w / 2.0, t, 8.0], [channel_w / 2.0, od - t, height + 1.0]);
let holster = outer - inner - box_from_corners([-channel_w / 4.0, od - t - 1.0, 8.0], [channel_w / 4.0, od + 1.0, height + 1.0]);
let lw = min(belt_w + 5.0, height - 6.0);
let loop_o = box_from_corners([-ow / 2.0, -5.0 - t, height / 2.0 - lw / 2.0], [ow / 2.0, 0.5, height / 2.0 + lw / 2.0]);
let loop_i = box_from_corners([-ow / 2.0 - 1.0, -5.0, height / 2.0 - lw / 2.0 + t], [ow / 2.0 + 1.0, 0.0, height / 2.0 + lw / 2.0 - t]);
let body = holster + (loop_o - loop_i);
body - cylinder([0, od / 2.0, -1.0], "Z", 3.0, 10.0)
