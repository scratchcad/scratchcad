// Car battery hold-down top bar: 180 mm long, 25 mm wide x 15 mm deep pressed U-channel in 3 mm steel, 8.5 mm J-bolt holes 160 mm apart, flattened ends
let length = 180.0; // [140.0, 300.0] Length (mm)
let width = 25.0; // [18.0, 35.0] Width (mm)
let depth = 15.0; // [8.0, 25.0] Channel depth (mm)
let sheet = 3.0; // [2.0, 4.0] Steel thickness (mm)
let hole_spacing = 160.0; // [100.0, 280.0] Bolt hole spacing (mm)
let bolt_d = 8.5; // [6.5, 10.5] Bolt hole (mm)
let hs = min(hole_spacing, length - 2.0 * bolt_d) / 2.0;
let flat_len = (length / 2.0 - hs) * 2.0 + 4.0;
let channel = box_centered(length - flat_len, width, depth).translate([0, 0, depth / 2.0]) - box_centered(length, width - 2.0 * sheet, depth).translate([0, 0, depth / 2.0 - sheet]);
let ends = [];
for s in [-1.0, 1.0] {
    ends.push(box_from_corners([s * (length / 2.0 - flat_len), -width / 2.0, depth - sheet], [s * length / 2.0, width / 2.0, depth]));
}
let bar = fuse_all([channel] + ends);
for s in [-1.0, 1.0] { bar = bar - cylinder([s * hs, 0, 0], "Z", bolt_d / 2.0, depth + 1.0); }
bar.fillet(4.0, bar.edges("|Z").filter(|e| abs(e.center().x) > length / 2.0 - 0.1))
