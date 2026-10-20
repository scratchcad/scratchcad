// Standard size duplex receptacle wall plate: 69.9 x 114.3 mm (2.75 x 4.5 in), 6 mm deep, two 34.9 mm round openings with flats 28.2 mm apart on 38.1 mm centers, countersunk center screw
let plate_w = 69.9; // [60.0, 90.0] Plate width (mm)
let plate_h = 114.3; // [100.0, 130.0] Plate height (mm)
let depth = 6.0; // [4.0, 10.0] Plate depth (mm)
let opening_d = 34.9; // [30.0, 36.0] Opening diameter (mm)
let flat_gap = 28.2; // [24.0, 30.0] Distance between opening flats (mm)
const t = 2.0;
const pitch = 38.1;
let p = box_centered(plate_w, plate_h, depth).translate([0, 0, depth / 2.0]).fillet(3.0, "|Z").chamfer(min(depth - t - 0.5, 2.5), ">Z");
p -= box_centered(plate_w - 2.0 * t, plate_h - 2.0 * t, depth).translate([0, 0, depth / 2.0 - t]).fillet(1.5, "|Z");
let fg = min(flat_gap, opening_d - 2.0);
for s in [-1.0, 1.0] {
    let o = cylinder([0, s * pitch / 2.0, -1], "Z", opening_d / 2.0, depth + 2.0) & box_centered(opening_d + 2.0, fg, 2.0 * depth + 4.0).translate([0, s * pitch / 2.0, 0]);
    p -= o;
}
p -= cylinder([0, 0, -1], "Z", 2.0, depth + 2.0) + cone(2.0, 3.8, 1.9).translate([0, 0, depth - 1.89]);
p
