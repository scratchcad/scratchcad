// Emergency stop mushroom head: 40 mm red push head 14 mm tall with a 3 mm domed top, 1.5 mm grip ribs on the rim, 16 mm stem 12 mm long with a 4 mm flat for the twist-release actuator
let head = 40.0; // [30.0, 60.0] Head diameter (mm)
let head_height = 14.0; // [10.0, 20.0] Head height (mm)
let stem = 16.0; // [12.0, 22.0] Stem diameter (mm)
let stem_length = 12.0; // [8.0, 20.0] Stem length (mm)
let r = head / 2.0;
// straight-segment profile: chamfered skirt and a faceted crown
let p = polygon("XZ", [[0, -stem_length], [stem / 2.0, -stem_length], [stem / 2.0, 0], [r - 2.0, 0], [r, 2.0], [r, head_height - 4.0], [r - 3.0, head_height - 1.5], [r * 0.5, head_height], [0, head_height]]);
let body = p.to_face().revolve([0, 0, 0], "Z", 360);
let ribs = [];
for k in 0..24 { ribs.push(cylinder([r + 0.3, 0, 2.5], "Z", 0.75, head_height - 7.0).rotate_z(k.to_float() * 15.0)); }
let flat = box_from_corners([stem / 2.0 - 4.0 + 2.0, -stem, -stem_length - 1.0], [stem, stem, -2.0]);
body - compound(ribs) - flat - cylinder([0, 0, -stem_length - 1.0], "Z", 3.0, stem_length - 1.0)
