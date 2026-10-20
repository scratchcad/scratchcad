// Spoke nipple driver bit for wheel building: 1/4 in (6.35 mm) hex shank 25 mm long, 5 mm round neck 8 mm long, 4.5 mm wide 1.0 mm thick screwdriver blade 2 mm long with a 1.8 mm centre pin standing 3 mm proud to keep the blade in the nipple slot
let shank_len = 25.0; // [16.0, 40.0] Shank length (mm)
let neck_len = 8.0; // [4.0, 15.0] Neck length (mm)
let blade_w = 4.5; // [3.5, 5.0] Blade width (mm)
let blade_t = 1.0; // [0.8, 1.4] Blade thickness (mm)
let pin_d = 1.8; // [1.4, 2.2] Centre pin diameter (mm)
const hex_af = 6.35;
const blade_len = 2.0;
const pin_len = 3.0;
let r = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let shank = polygon(pts).to_face().extrude([0, 0, shank_len]);
let z1 = shank_len + neck_len;
fuse_all([
    shank,
    cylinder([0, 0, shank_len - 0.5], "Z", 2.5, neck_len + 0.5),
    box_from_corners([-blade_w / 2.0, -blade_t / 2.0, z1 - 0.5], [blade_w / 2.0, blade_t / 2.0, z1 + blade_len]),
    cylinder([0, 0, z1 - 0.5], "Z", pin_d / 2.0, blade_len + pin_len + 0.5),
])
