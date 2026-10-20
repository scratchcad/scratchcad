// 2-way D-series connector panel: 70 x 40 x 2 mm plate, two 24 mm XLR cut-outs on 30 mm centres with M3 fixing holes at 19 x 24 mm diagonal, and four 3.5 mm corner holes
let width = 70.0; // [60.0, 100.0] Panel width (mm)
let height = 40.0; // [36.0, 60.0] Panel height (mm)
let t = 2.0; // [1.5, 4.0] Panel thickness (mm)
let p = box_centered(width, height, t).translate([0, 0, t / 2.0]);
let p = p.fillet(3.0, p.edges("|Z"));
let cuts = [];
for x in [-15.0, 15.0] {
    cuts.push(cylinder([x, 0, -1.0], "Z", 12.0, t + 2.0));
    cuts.push(cylinder([x - 9.5, 12.0, -1.0], "Z", 1.6, t + 2.0));
    cuts.push(cylinder([x + 9.5, -12.0, -1.0], "Z", 1.6, t + 2.0));
}
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { cuts.push(cylinder([sx * (width / 2.0 - 4.0), sy * (height / 2.0 - 4.0), -1.0], "Z", 1.75, t + 2.0)); } }
p - fuse_all(cuts)
