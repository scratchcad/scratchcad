// Motorcycle swingarm chain guide block for a 520 chain: 110 x 30 x 38 mm, 20 x 24 mm chain window, flared ends, two M6 mounting holes 60 mm apart
let length = 110.0; // [70.0, 160.0] Length (mm)
let width = 30.0; // [24.0, 40.0] Width (mm)
let height = 38.0; // [30.0, 50.0] Height (mm)
let window_w = 20.0; // [14.0, 26.0] Chain window width (mm)
let window_h = 24.0; // [16.0, 30.0] Chain window height (mm)
let hole_spacing = 60.0; // [30.0, 120.0] Mounting hole spacing (mm)
const bolt = 6.5;
let wh = min(window_h, height - 12.0);
let ww = min(window_w, width - 6.0);
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(3.0, "|X");
let window = box_centered(length + 2.0, ww, wh).translate([0, 0, 3.0 + wh / 2.0]);
let flare = loft([rect(plane([length / 2.0 - 12.0, 0, 3.0 + wh / 2.0], [1, 0, 0]), ww, wh), rect(plane([length / 2.0 + 0.5, 0, 3.0 + wh / 2.0], [1, 0, 0]), ww + 6.0, wh + 4.0)], true);
let guide = body - window - flare - flare.mirror("YZ");
let hs = min(hole_spacing, length - 20.0) / 2.0;
for sx in [-1.0, 1.0] {
    guide = guide - cylinder([sx * hs, 0, 0], "Z", bolt / 2.0, height + 1.0) - cylinder([sx * hs, 0, height - 3.0], "Z", 5.5, 4.0);
}
guide
