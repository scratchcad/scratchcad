// Sickle bar knife hold-down clip: 40 x 40 x 6 mm base pad with two 10.5 mm bolt holes 20 mm apart, and a 25 mm wide tongue 5 mm thick reaching 30 mm forward and dropping 8 mm to bear on the knife back, with 3 mm rounded tongue corners
let base_len = 40.0; // [30.0, 55.0] Base length (mm)
let width = 40.0; // [32.0, 55.0] Base width (mm)
let tongue_len = 30.0; // [20.0, 45.0] Tongue reach (mm)
let tongue_w = 25.0; // [16.0, 35.0] Tongue width (mm)
let drop = 8.0; // [3.0, 12.0] Tongue drop (mm)
const t = 6.0;
const tt = 5.0;
const bolt_d = 10.5;
let tw = min(tongue_w, width - 4.0);
let base = box_from_corners([0, -width / 2.0, 0], [base_len, width / 2.0, t]);
let x1 = base_len + tongue_len;
let tongue = polygon([[base_len - 5.0, -tw / 2.0, 0], [x1, -tw / 2.0, -drop], [x1, -tw / 2.0, -drop + tt], [base_len - 5.0, -tw / 2.0, t]]).to_face().extrude([0, tw, 0]);
let tongue = tongue.fillet(3.0, tongue.edges("|Z and >X"));
(base + tongue) - fuse_all([
    cylinder([base_len * 0.4, -10.0, -1.0], "Z", bolt_d / 2.0, t + 2.0),
    cylinder([base_len * 0.4, 10.0, -1.0], "Z", bolt_d / 2.0, t + 2.0),
])
