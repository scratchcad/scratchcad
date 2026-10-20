// End bracket for a 10 x 15 mm drag chain: 40 x 26 mm base plate 3 mm with 2 x M3 holes, two 2.5 mm cheeks 15 mm apart (inside) and 14 mm tall with 4 mm pin bosses that snap into the chain end link, 5 mm cable tie slot
let chain_w = 15.0; // [10.0, 30.0] Chain inside width (mm)
let cheek_h = 14.0; // [10.0, 25.0] Cheek height (mm)
let pin_d = 4.0; // [3.0, 6.0] Pin diameter (mm)
let base_l = 40.0; // [40.0, 70.0] Base length (mm)
const cheek_t = 2.5;
const base_t = 3.0;
const cheek_l = 16.0;
let width = chain_w + 2.0 * cheek_t + 6.0;
let base = box_from_corners([0, -width / 2.0, 0], [base_l, width / 2.0, base_t]);
base = base.fillet(3.0, "|Z");
let parts = [base];
for sy in [-1.0, 1.0] {
    let y_in = sy * chain_w / 2.0;
    let y_out = sy * (chain_w / 2.0 + cheek_t);
    let cheek = box_from_corners([base_l - cheek_l, min(y_in, y_out), base_t - 0.5], [base_l, max(y_in, y_out), base_t + cheek_h]);
    cheek = cheek.fillet(cheek_l / 2.0 - 0.5, cheek.edges("|Y and >Z"));
    parts.push(cheek);
    // pin boss pointing inward to engage the link's hole
    parts.push(cylinder([base_l - cheek_l / 2.0, y_in, base_t + cheek_h - cheek_l / 2.0], [0, -sy, 0], pin_d / 2.0, 1.5).translate([0, sy * 0.5, 0]));
}
let bracket = fuse_all(parts);
let holes = [];
for x in [5.0, base_l - cheek_l - 4.0] {
    holes.push(cylinder([x, 0, -1], "Z", 1.6, base_t + 2.0));
}
holes.push(box_centered(3.0, 5.0, base_t + 2.0).translate([(base_l - cheek_l + 1.0) / 2.0, 0, base_t / 2.0]));
bracket - fuse_all(holes)
