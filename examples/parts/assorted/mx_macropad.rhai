// Cherry MX switch plate, 3 x 2 keys
let columns = 3; // [1, 10] Key columns
let rows = 2; // [1, 6] Key rows
let spacing = 19.05; // [18.0, 20.0] Key spacing (mm)
let cutout = 14.0; // [13.8, 14.2] Switch cutout (mm)
let thickness = 1.5; // [1.2, 1.6] Plate thickness (mm)
let border = 5.0; // [3.0, 12.0] Border (mm)
let w = columns.to_float() * spacing + 2.0 * border;
let h = rows.to_float() * spacing + 2.0 * border;
let plate = box_centered(w, h, thickness).translate([0, 0, thickness / 2.0]).fillet(3.0, "|Z");
let cuts = [];
for i in 0..columns { for j in 0..rows {
    let x = (i.to_float() - (columns - 1).to_float() / 2.0) * spacing;
    let y = (j.to_float() - (rows - 1).to_float() / 2.0) * spacing;
    cuts.push(box_centered(cutout, cutout, thickness + 2.0).translate([x, y, thickness / 2.0]));
} }
for sx in [-1, 1] { for sy in [-1, 1] {
    cuts.push(cylinder([sx * (w / 2.0 - border / 2.0), sy * (h / 2.0 - border / 2.0), -1], "Z", 1.1, thickness + 2.0));
} }
plate - fuse_all(cuts)
