// Rear mounting bracket for a drawer slide: 2 mm steel, 40 mm tall back flange with 2 x 5 mm holes, 25 mm slide tab
let thickness = 2.0; // [1.0, 4.0] Thickness (mm)
let height = 40.0; // [25.0, 80.0] Flange height (mm)
let width = 20.0; // [12.0, 40.0] Width (mm)
let tab = 25.0; // [15.0, 50.0] Tab length (mm)
let flange = box(width, thickness, height);
let tab_part = box(width * 0.6, tab, thickness).translate([width * 0.2, thickness - 0.01, height * 0.5]);
let part = flange + tab_part;
for z in [height * 0.2, height * 0.8] { part -= cylinder([width / 2.0, -1, z], "Y", 2.5, thickness + 2.0); }
part - cylinder([width / 2.0, thickness + tab * 0.7, height * 0.5 - 1], "Z", 2.0, thickness + 2.0)
