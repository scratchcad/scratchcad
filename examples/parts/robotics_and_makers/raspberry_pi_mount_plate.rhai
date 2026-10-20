// Raspberry Pi 4 / 5 mounting plate: 100 x 70 mm 3 mm plate with 6 mm standoffs 5 mm tall on the 58 x 49 mm M2.5 hole pattern, cooling slots under the SoC and four M3 corner holes
let plate_l = 100.0; // [90.0, 140.0] Plate length (mm)
let plate_w = 70.0; // [60.0, 100.0] Plate width (mm)
let standoff_h = 5.0; // [3.0, 12.0] Standoff height (mm)
let slots = 6; // [0, 10] Number of cooling slots
const t = 3.0;
const px = 58.0;
const py = 49.0;
let p = box_centered(plate_l, plate_w, t).translate([0, 0, t / 2.0]).fillet(5.0, "|Z");
let x0 = -px / 2.0;
let bosses = [];
for x in [x0, x0 + px] { for y in [-py / 2.0, py / 2.0] { bosses.push(cylinder([x, y, t - 0.01], "Z", 3.0, standoff_h)); } }
p = fuse_all([p] + bosses);
for x in [x0, x0 + px] { for y in [-py / 2.0, py / 2.0] { p -= cylinder([x, y, -1], "Z", 1.1, t + standoff_h + 2.0); } }
for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { p -= cylinder([x * (plate_l / 2.0 - 5.0), y * (plate_w / 2.0 - 5.0), -1], "Z", 1.6, t + 2.0); } }
for i in 0..slots {
    let y = -15.0 + 30.0 * (i.to_float() + 0.5) / slots.to_float();
    p -= box_centered(30.0, 2.5, 10.0).translate([0, y, 0]).fillet(1.2, "|Z");
}
p
