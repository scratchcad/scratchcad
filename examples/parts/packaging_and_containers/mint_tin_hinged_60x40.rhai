// Hinged mint tin, 60 x 40 mm: 12 mm deep base and 5 mm lid, 0.6 mm walls, 6 mm corner radius, lid telescoping 3 mm over the base with 0.1 mm clearance, rolled hinge knuckles with a 1 mm pin along the back
let length = 60.0; // [40.0, 100.0] Tin length (mm)
let width = 40.0; // [25.0, 65.0] Tin width (mm)
let base_height = 12.0; // [6.0, 25.0] Base height (mm)
let lid_height = 5.0; // [3.0, 10.0] Lid height (mm)
let corner = 6.0; // [2.0, 12.0] Corner radius (mm)
let wall = 0.6; // [0.4, 1.2] Wall thickness (mm)
let rc = max(corner, wall + 1.0);
fn rounded(l, w, h, r, z) {
    box_centered(l, w, h).fillet(r, "|Z").translate([0, 0, z + h / 2.0])
}
let base = rounded(length, width, base_height, rc, 0).fillet(1.0, "<Z") - rounded(length - 2.0 * wall, width - 2.0 * wall, base_height, rc - wall, wall).fillet(0.5, "<Z");
let lo = length + 2.0 * (wall + 0.1);
let wo = width + 2.0 * (wall + 0.1);
let z_lid = base_height - 3.0;
let lid = rounded(lo, wo, lid_height, rc + wall + 0.1, z_lid).fillet(1.0, ">Z") - rounded(length + 0.2, width + 0.2, lid_height - wall, rc + 0.1, z_lid - 0.01);
// hinge knuckles along the back (-Y): two on the base, one on the lid
let yh = -wo / 2.0 - 0.8;
let zh = z_lid;
let kw = length / 5.0;
let base_k = [];
for x0 in [-2.5 * kw, 1.5 * kw] {
    base_k.push(cylinder([x0 + 0.1, yh, zh], "X", 1.1, kw - 0.2) + box_from_corners([x0 + 0.1, yh, zh - 3.0], [x0 + kw - 0.1, -width / 2.0 + 0.3, zh - 0.5]));
}
let lid_k = cylinder([-1.5 * kw + 0.2, yh, zh], "X", 1.1, 3.0 * kw - 0.4) + box_from_corners([-1.5 * kw + 0.2, yh, zh + 0.5], [1.5 * kw - 0.2, -wo / 2.0 + 0.3, zh + 2.0]);
let pin = cylinder([-3.0 * kw, yh, zh], "X", 0.5, 6.0 * kw);
base = fuse_all([base] + base_k) - pin;
lid = (lid + lid_k) - pin;
[base, lid]
