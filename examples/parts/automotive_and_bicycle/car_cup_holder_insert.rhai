// Cup holder insert: tapered 72-80 mm cup 70 mm deep, 2 mm wall, 3 mm floor, 88 mm rim, six tapered grip ribs
let base = 72.0; // [60.0, 80.0] Base diameter (mm)
let depth = 70.0; // [50.0, 90.0] Depth (mm)
const taper = 4.0 / 70.0;
let top = base / 2.0 + taper * depth;
let cup = cone(base / 2.0, top, depth) - cone(base / 2.0 - 2.0 + taper * 3.0, top - 2.0 + taper, depth - 2.0).translate([0, 0, 3.0]);
let rim = cylinder([0, 0, depth - 3.0], "Z", top + 4.0, 3.0) - cylinder([0, 0, depth - 4.0], "Z", top - 1.8, 6.0);
let r3 = base / 2.0 - 2.0 + taper * 3.0;
let r45 = base / 2.0 - 2.0 + taper * 45.0;
let rib = polygon([[r3 - 3.2, 0, 3], [r3 + 0.4, 0, 3], [r45 + 0.1, 0, 45], [r45 - 3.6, 0, 45]]).to_face().extrude([0, 2.0, 0]).translate([0, -1.0, 0]);
let ribs = [];
for k in 0..6 { ribs.push(rib.rotate("Z", k.to_float() * 60.0)); }
fuse_all([cup, rim] + ribs)
