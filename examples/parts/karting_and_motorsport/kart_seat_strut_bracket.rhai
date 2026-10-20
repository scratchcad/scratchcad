// Kart seat strut bracket: 4 mm angle bracket, 50 x 25 mm base with an 8.5 mm M8 hole, 45 mm upright with an 8.5 x 25 mm adjusting slot, braced by two 4 mm triangular gussets along the edges and 2 mm rounded corners
let width = 25.0; // [20.0, 40.0] Bracket width (mm)
let base_len = 50.0; // [35.0, 70.0] Base length (mm)
let upright_h = 45.0; // [35.0, 70.0] Upright height (mm)
let thickness = 4.0; // [3.0, 6.0] Plate thickness (mm)
let base = box_from_corners([0, -width / 2.0, 0], [base_len, width / 2.0, thickness]);
let base = base.fillet(2.0, base.edges("|Z and >X"));
let up = box_from_corners([0, -width / 2.0, 0], [thickness, width / 2.0, upright_h]);
let up = up.fillet(2.0, up.edges("|X and >Z"));
let g = min(base_len, upright_h) * 0.5;
let gusset = face(polygon([[0, width / 2.0 - 4.0, 0], [g, width / 2.0 - 4.0, 0], [0, width / 2.0 - 4.0, g]])).extrude([0, 4.0, 0]);
let body = fuse_all([base, up, gusset, gusset.mirror("XZ")]);
let sl = min(25.0, upright_h - 22.0);
let zc = upright_h - 8.0 - sl / 2.0;
let cuts = [
    cylinder([base_len - 12.0, 0, -1.0], "Z", 4.25, thickness + 2.0),
    box_centered(thickness + 2.0, 8.5, sl - 8.5).translate([thickness / 2.0, 0, zc]),
    cylinder([-1.0, 0, zc - (sl - 8.5) / 2.0], "X", 4.25, thickness + 2.0),
    cylinder([-1.0, 0, zc + (sl - 8.5) / 2.0], "X", 4.25, thickness + 2.0)
];
body - fuse_all(cuts)
