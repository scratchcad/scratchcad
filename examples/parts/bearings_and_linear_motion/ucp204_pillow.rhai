// UCP204 pillow block: 20 mm bore, 127 mm long, 38 mm wide base, 33.3 mm shaft height, 96 mm bolt centers
let length = 127.0; // [100.0, 160.0] Base length (mm)
let base_w = 38.0; // [30.0, 50.0] Base width (mm)
let shaft_h = 33.3; // [25.0, 45.0] Shaft center height (mm)
let bolt_centers = 96.0; // [70.0, 130.0] Bolt centers (mm)
let bore = 20.0; // [12.0, 35.0] Bore (mm)
let housing_r = 32.0; // [24.0, 45.0] Housing radius (mm)
let base_t = 14.0;
let base = box_centered(length, base_w, base_t).translate([0, 0, base_t / 2.0]).fillet(6.0, "|Z");
let body = cylinder([0, -base_w / 2.0 + 3.0, shaft_h], "Y", housing_r, base_w - 6.0) + box_centered(housing_r * 1.6, base_w - 6.0, shaft_h).translate([0, 0, shaft_h / 2.0]);
let part = base + body;
part = part - cylinder([0, -base_w, shaft_h], "Y", bore / 2.0 + 6.0, base_w * 2.0);
for s in [-1, 1] { part -= box_centered(16.0, 13.0, base_t * 3.0).translate([s * bolt_centers / 2.0, 0, 0]).fillet(6.0, "|Z"); }
let insert = cylinder([0, -15.5, shaft_h], "Y", bore / 2.0 + 6.0, 31.0) - cylinder([0, -20, shaft_h], "Y", bore / 2.0, 40.0);
[part, insert]
