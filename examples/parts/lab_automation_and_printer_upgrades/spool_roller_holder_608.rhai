// Filament spool roller holder for 608 bearings: 140 x 34 mm base 5 mm, two roller forks 80 mm apart, each with two 5 mm cheeks 24 mm wide holding an 8 mm axle 16 mm up, 22 mm gap for a pair of 608 bearings (22 x 7 mm), 4 x 4.5 mm screw holes
let roller_spacing = 80.0; // [50.0, 120.0] Roller spacing (mm)
let axle_h = 16.0; // [14.0, 30.0] Axle height (mm)
let gap = 22.0; // [8.0, 40.0] Bearing gap between the cheeks (mm)
let axle_d = 8.2; // [5.0, 8.5] Axle hole (mm)
const cheek_t = 5.0;
const cheek_w = 24.0;
const base_t = 5.0;
let width = gap + 2.0 * cheek_t;
let length = roller_spacing + cheek_w + 36.0;
let base = box_centered(length, width, base_t).translate([0, 0, base_t / 2.0]);
base = base.fillet(5.0, "|Z");
let parts = [base];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let y = sy * (gap + cheek_t) / 2.0;
        let x = sx * roller_spacing / 2.0;
        let cheek = box_centered(cheek_w, cheek_t, axle_h).translate([x, y, axle_h / 2.0 + base_t - 0.5]) + cylinder([x, y - cheek_t / 2.0, axle_h + base_t - 0.5], "Y", cheek_w / 2.0, cheek_t);
        parts.push(cheek);
    }
}
let holder = fuse_all(parts);
let cuts = [];
for sx in [-1.0, 1.0] {
    cuts.push(cylinder([sx * roller_spacing / 2.0, -width, axle_h + base_t - 0.5], "Y", axle_d / 2.0, 2.0 * width));
    cuts.push(cylinder([sx * (length / 2.0 - 9.0), 0, -1], "Z", 2.25, base_t + 2.0));
}
cuts.push(cylinder([0, 0, -1], "Z", 2.25, base_t + 2.0));
holder - compound(cuts)
