// L bracket for a yellow TT gear motor (22.5 mm wide gearbox): 3 mm upright 25 x 30 mm with two 3.2 mm through-holes 17.5 mm apart and a 7 mm shaft-boss clearance hole, 25 mm base with two M3 chassis slots, rib
let upright_h = 30.0; // [22.0, 45.0] Upright height (mm)
let width = 25.0; // [22.0, 35.0] Bracket width (mm)
let base_d = 25.0; // [15.0, 40.0] Base depth (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
const hole_spacing = 17.5;
let up = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, upright_h]);
let base = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, base_d, t]);
let rib = polygon("YZ", [[t - 0.01, t - 0.01], [base_d * 0.7, t - 0.01], [t - 0.01, upright_h * 0.7]]).to_face().extrude([2.0, 0, 0]).translate([-1.0, 0, 0]);
let b = fuse_all([up, base, rib]);
let zc = t + (upright_h - t) * 0.55;
for s in [-1.0, 1.0] { b -= cylinder([s * hole_spacing / 2.0, -1, zc], "Y", 1.6, t + 2.0); }
b -= cylinder([0, -1, zc + 9.0], "Y", 3.5, t + 2.0) & box_from_corners([-10, -2, 0], [10, t + 2.0, upright_h - 1.5]);
for s in [-1.0, 1.0] {
    let x = s * width * 0.3;
    b -= box_centered(3.4, 6.0, 10.0).translate([x, base_d * 0.65, 0]) + cylinder([x, base_d * 0.65 - 3.0, -1], "Z", 1.7, t + 2.0) + cylinder([x, base_d * 0.65 + 3.0, -1], "Z", 1.7, t + 2.0);
}
b.fillet(1.5, "|Y and >Z").fillet(1.5, "|Z and >Y")
