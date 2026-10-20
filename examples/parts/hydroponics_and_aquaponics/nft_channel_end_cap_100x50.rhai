// NFT gully end cap for 100 x 50 mm channel: a 3 mm end plate 104.8 x 54.8 mm with a 12 mm deep push-on skirt 2 mm thick that fits over the channel, 2 mm corner radii, and a 20 mm drain spigot 25 mm long with a 16 mm bore low in the plate
let channel_w = 100.0; // [60.0, 150.0] Channel width (mm)
let channel_h = 50.0; // [30.0, 100.0] Channel height (mm)
let skirt_depth = 12.0; // [6.0, 25.0] Skirt depth (mm)
let spigot_d = 20.0; // [12.0, 32.0] Drain spigot outside diameter (mm)
const t = 3.0;
const skirt_t = 2.0;
const clear = 0.4;
let iw = channel_w + 2.0 * clear;
let ih = channel_h + 2.0 * clear;
let ow = iw + 2.0 * skirt_t;
let oh = ih + 2.0 * skirt_t;
let outer = box_centered(ow, oh, t + skirt_depth).translate([0, 0, (t + skirt_depth) / 2.0]);
let outer = outer.fillet(2.0, outer.edges("|Z"));
let inner = box_centered(iw, ih, skirt_depth + 1.0).translate([0, 0, t + (skirt_depth + 1.0) / 2.0]);
let cap = outer - inner;
let sd = min(spigot_d, channel_h - 6.0);
let sy = -ih / 2.0 + sd / 2.0 + 1.0;
let spigot = cylinder([0, sy, -25.0], "Z", sd / 2.0, 25.0 + t / 2.0);
let bore = cylinder([0, sy, -26.0], "Z", sd / 2.0 - 2.0, 30.0 + t);
(cap + spigot) - bore
