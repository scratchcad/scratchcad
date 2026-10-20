// D-series DMX connector panel plate: 2 mm plate 40 x 40 mm carrying one XLR-5 D-series cutout (24 mm hole, M3 holes at 19 x 24 mm diagonal pitch), four 3.5 mm corner fixing holes
let plate = 40.0; // [32.0, 60.0] Plate size (mm)
let thickness = 2.0; // [1.5, 3.0] Plate thickness (mm)
let hole = 24.0; // [22.0, 26.0] Connector hole (mm)
let p = box_centered(plate, plate, thickness).translate([0, 0, thickness / 2.0]);
let pl = p.fillet(3.0, p.edges("|Z"));
let cuts = [cylinder([0, 0, -1.0], "Z", hole / 2.0, thickness + 2.0)];
// D-series M3 holes sit on opposite corners of a 19 x 24 mm rectangle
cuts.push(cylinder([-9.5, 12.0, -1.0], "Z", 1.6, thickness + 2.0));
cuts.push(cylinder([9.5, -12.0, -1.0], "Z", 1.6, thickness + 2.0));
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { cuts.push(cylinder([sx * (plate / 2.0 - 4.0), sy * (plate / 2.0 - 4.0), -1.0], "Z", 1.75, thickness + 2.0)); } }
pl - fuse_all(cuts)
