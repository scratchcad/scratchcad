// Hospital bed castor brake pedal cap: 62 x 36 mm rubber pad 14 mm tall with five 2 mm anti-slip ribs on top, 2 mm chamfered edges and a 50 x 24 mm pocket 9 mm deep underneath for the steel pedal tab
let pad_l = 62.0; // [45.0, 80.0] Pad length (mm)
let pad_w = 36.0; // [28.0, 50.0] Pad width (mm)
let pedal_t = 9.0; // [5.0, 10.0] Pocket depth (mm)
let ribs = 5; // [3, 8] Number of ribs
const h = 12.0;
let p = box_from_corners([-pad_l / 2.0, -pad_w / 2.0, 0], [pad_l / 2.0, pad_w / 2.0, h]);
p = p.chamfer(2.0, p.edges(">Z"));
let rs = [];
for i in 0..ribs {
    let x = -pad_l / 2.0 + 6.0 + (pad_l - 12.0) * i.to_float() / (ribs.to_float() - 1.0);
    rs.push(box_from_corners([x - 1.5, -pad_w / 2.0 + 4.0, h - 0.01], [x + 1.5, pad_w / 2.0 - 4.0, h + 2.0]));
}
p + compound(rs) - box_from_corners([-pad_l / 2.0 + 6.0, -pad_w / 2.0 + 6.0, -1.0], [pad_l / 2.0 - 6.0, pad_w / 2.0 - 6.0, pedal_t])
