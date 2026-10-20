// Washroom dispenser quarter-turn cam lock tongue: 3 mm steel-style tongue 40 mm long and 16 mm wide with a rounded 8 mm end radius, a 10 x 8 mm double-D hole for the lock barrel, and a 3 mm curved hook lip 4 mm tall following the free end that catches the cabinet
let tongue_len = 40.0; // [25.0, 60.0] Tongue length (mm)
let width = 16.0; // [12.0, 24.0] Tongue width (mm)
let thickness = 3.0; // [2.0, 5.0] Tongue thickness (mm)
let lip_h = 4.0; // [0.0, 8.0] Hook lip height (mm)
const flat_w = 8.0;
const round_d = 10.0;
let r = width / 2.0;
let tongue = box_from_corners([0, -r, 0], [tongue_len - r, r, thickness]) + cylinder([0, 0, 0], "Z", r, thickness) + cylinder([tongue_len - r, 0, 0], "Z", r, thickness);
let parts = [tongue];
if lip_h > 0.1 {
    parts.push(box_from_corners([tongue_len - 3.0, -r, thickness - 0.5], [tongue_len + 1.0, r, thickness + lip_h]) & cylinder([tongue_len - r, 0, thickness - 0.5], "Z", r, lip_h + 0.5));
}
let body = fuse_all(parts);
let rr = min(round_d / 2.0, r - 2.0);
let dd = cylinder([0, 0, -1.0], "Z", rr, thickness + 2.0) & box_centered(2.0 * rr + 1.0, min(flat_w, 2.0 * rr - 1.0), thickness + 4.0).translate([0, 0, thickness / 2.0]);
body - dd
