// Kart throttle cable abutment bracket: 3 mm L bracket 20 mm wide, 30 mm base with an M6 hole (6.4 mm), 30 mm upright with a 6.2 mm hole for the cable adjuster and a 2.5 mm slot from the hole to the side so the inner cable slides in, 2 mm rounded upright corners
let width = 20.0; // [16.0, 30.0] Bracket width (mm)
let upright_h = 30.0; // [22.0, 50.0] Upright height (mm)
let base_len = 30.0; // [22.0, 45.0] Base length (mm)
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
const adjuster_d = 6.2;
let base = box_from_corners([0, -width / 2.0, 0], [base_len, width / 2.0, thickness]);
let up = box_from_corners([0, -width / 2.0, 0], [thickness, width / 2.0, upright_h]);
let up = up.fillet(2.0, up.edges("|X and >Z"));
let body = base + up;
let zh = upright_h - 10.0;
let cuts = [
    cylinder([base_len - 10.0, 0, -1.0], "Z", 3.2, thickness + 2.0),
    cylinder([-1.0, 0, zh], "X", adjuster_d / 2.0, thickness + 2.0),
    box_from_corners([-1.0, 0, zh - 1.25], [thickness + 1.0, width / 2.0 + 1.0, zh + 1.25])
];
body - fuse_all(cuts)
