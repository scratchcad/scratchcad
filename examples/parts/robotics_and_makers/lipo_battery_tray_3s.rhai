// Tray for a 3S 2200 mAh LiPo pack (105 x 34 x 25 mm): 2 mm floor and 8 mm side lips, two 20 x 3 mm hook-and-loop strap slots, balance lead notch, four M3 mounting holes
let pack_l = 105.0; // [70.0, 160.0] Pack length (mm)
let pack_w = 34.0; // [25.0, 50.0] Pack width (mm)
let lip = 8.0; // [4.0, 15.0] Side lip height (mm)
let strap_w = 20.0; // [10.0, 30.0] Strap width (mm)
const t = 2.0;
let l = pack_l + 1.0 + 2.0 * t;
let w = pack_w + 1.0 + 2.0 * t;
let tray = box_centered(l, w, lip + t).translate([0, 0, (lip + t) / 2.0]).fillet(3.0, "|Z") - box_centered(l - 2.0 * t, w - 2.0 * t, lip + t).translate([0, 0, (lip + t) / 2.0 + t]).fillet(1.5, "|Z");
let sw = min(strap_w, w - 8.0);
for s in [-1.0, 1.0] {
    tray -= box_centered(3.0, sw, 10.0).translate([s * l * 0.28, 0, 0]);
    tray -= box_centered(sw, 4.0, lip).translate([s * l * 0.28, s * 0.0, t + lip / 2.0 + 1.0]).rotate_z(0.0) & box_centered(2.0 * l, 2.0 * w, 2.0 * lip);
}
tray -= box_centered(t * 3.0, 12.0, lip).translate([l / 2.0, 0, t + lip / 2.0 + 1.0]);
for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { tray -= cylinder([x * (l / 2.0 - 8.0), y * (w / 2.0 - 6.0), -1], "Z", 1.6, t + 2.0); } }
tray
