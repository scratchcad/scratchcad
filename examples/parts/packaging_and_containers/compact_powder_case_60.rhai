// Round powder compact, 60 mm: 8 mm base with a 53 mm pan well 5 mm deep, 5 mm lid with a 50 mm mirror recess, three-knuckle hinge with a 1.2 mm pin hole at the back, finger tab at the front
let diameter = 60.0; // [40.0, 90.0] Compact diameter (mm)
let base_height = 8.0; // [5.0, 14.0] Base height (mm)
let lid_height = 5.0; // [3.0, 8.0] Lid height (mm)
let pan_diameter = 53.0; // [30.0, 80.0] Pan well diameter (mm)
let pan_depth = 5.0; // [2.0, 10.0] Pan well depth (mm)
let mirror_diameter = 50.0; // [30.0, 80.0] Mirror recess diameter (mm)
let r = diameter / 2.0;
let rp = min(pan_diameter / 2.0, r - 2.0);
let rm = min(mirror_diameter / 2.0, r - 2.5);
let pd = min(pan_depth, base_height - 1.5);
let base = cylinder(r, base_height).fillet(1.5, "<Z") - cylinder([0, 0, base_height - pd], "Z", rp, pd + 1.0);
let z_split = base_height + 0.2;
let lid = cylinder([0, 0, z_split], "Z", r, lid_height).fillet(1.5, ">Z") - cylinder([0, 0, z_split - 1.0], "Z", rm, 2.5);
// hinge on the -Y side, axis along X at the parting line
let yh = -r - 1.0;
let zh = z_split - 0.1;
const rk = 1.8;
const kw = 6.0;
let knuckle = |x0, w| cylinder([x0, yh, zh], "X", rk, w);
base = base + knuckle.call(-1.5 * kw - 0.2, kw) + knuckle.call(0.5 * kw + 0.2, kw) + box_from_corners([-1.5 * kw - 0.2, yh, zh - rk - 1.5], [-0.5 * kw - 0.2, -r + 2.0, zh - 0.3]) + box_from_corners([0.5 * kw + 0.2, yh, zh - rk - 1.5], [1.5 * kw + 0.2, -r + 2.0, zh - 0.3]);
lid = lid + knuckle.call(-0.5 * kw, kw) + box_from_corners([-0.5 * kw, yh, zh + 0.3], [0.5 * kw, -r + 2.0, zh + rk + 1.0]);
let pin = cylinder([-2.0 * kw, yh, zh], "X", 0.6, 4.0 * kw);
// clearance between the base's knuckle blocks and the lid's knuckle
base = base - cylinder([-0.5 * kw - 0.2, yh, zh], "X", rk + 0.2, kw + 0.4);
lid = lid - box_from_corners([-2.0 * kw, yh - rk - 1.0, zh - rk - 2.0], [2.0 * kw, -r + 2.5, zh + 0.1]) - pin;
base = base - pin;
// finger tab on the lid at +Y
lid = lid + box_from_corners([-6.0, r - 2.0, z_split], [6.0, r + 2.5, z_split + 1.2]).fillet(1.0, "|Z and >Y");
[base, lid]
