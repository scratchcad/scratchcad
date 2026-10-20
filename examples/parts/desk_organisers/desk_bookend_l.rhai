// Desk bookend: L-shaped, 130 mm tall upright 120 mm wide, 100 mm foot slid under the books, 4 mm thick with two 30 mm triangular gussets, rounded corners, 12 mm non-slip pad recesses under the foot
let height = 130.0; // [80.0, 200.0] Upright height (mm)
let width = 120.0; // [80.0, 160.0] Width (mm)
let foot = 100.0; // [60.0, 150.0] Foot length (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let gusset = 30.0; // [15.0, 50.0] Gusset size (mm)

let upright = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height]);
upright = upright.fillet(12.0, upright.edges("|Y and >Z"));
let base = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, foot, t]);
base = base.fillet(10.0, base.edges("|Z and >Y"));
let g = min(gusset, min(foot, height) - 10.0);
let gs = polygon([[-t, t - 0.5, t - 0.5], [-t, t - 0.5 + g, t - 0.5], [-t, t - 0.5, t - 0.5 + g * 1.5]]).to_face().extrude([2.0 * t, 0, 0]);
let be = fuse_all([upright, base, gs.translate([-width / 2.0 + 15.0, 0, 0]), gs.translate([width / 2.0 - 15.0, 0, 0])]);
for x in [-width / 2.0 + 20.0, width / 2.0 - 20.0] {
    be = be - cylinder([x, foot - 20.0, -1.0], "Z", 6.1, 2.0);
}
be
