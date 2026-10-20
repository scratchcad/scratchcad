// Three-wing indoor boomerang: 220 mm span flat polygon wings 25 mm wide, 3 mm thick, 120 degrees apart, joined at a round hub
let span = 220.0; // [150.0, 300.0] Tip-to-tip span (mm)
let width = 25.0; // [18.0, 35.0] Wing width (mm)
const t = 3.0;
let len = span / 2.0 / cos(30.0 * PI() / 180.0);
let wings = [];
for i in 0..3 { wings.push(box_from_corners([0, -width / 2.0, 0], [len, width / 2.0, t]).rotate_z(90.0 + 120.0 * i.to_float())); }
let hub = cylinder([0, 0, 0], "Z", width * 0.8, t);
fuse_all(wings) + hub
