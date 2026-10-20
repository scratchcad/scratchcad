// 86 mm piston: 60 mm tall, 32 mm compression height, 21 mm pin bore in bosses, three ring grooves, four valve reliefs
let bore = 86.0; // [70.0, 100.0] Bore (mm)
let h = 60.0; // [50.0, 75.0] Overall height (mm)
let ch = 32.0; // [25.0, 40.0] Compression height (mm)
let r = bore / 2.0 - 0.05;
let zp = h - ch;
let p = cylinder(r, h) - cylinder([0, 0, -1], "Z", r - 5.0, h - 14.0 + 1.0);
p += cylinder([0, -r, zp], "Y", 14.0, 2.0 * r) & cylinder(r - 1.0, h);
p -= box_from_corners([-r + 5.0, -13.0, -1.0], [r - 5.0, 13.0, h - 14.0]);
p -= cylinder([0, -r - 1.0, zp], "Y", 10.5, 2.0 * r + 2.0);
for g in [[h - 5.5, 1.2], [h - 9.5, 1.5], [h - 14.0, 2.5]] { p -= cylinder([0, 0, g[0]], "Z", r + 1.0, g[1]) - cylinder([0, 0, g[0] - 1.0], "Z", r - 4.0, g[1] + 2.0); }
for x in [-15.0, 15.0] { for y in [-17.0, 17.0] { p -= cylinder([x, y, h - 1.2], "Z", 16.0, 2.0); } }
p
