// Race car tow strap bracket: 6 mm steel angle with an 80 x 40 mm base carrying two M10 clearance holes (10.5 mm) 50 mm apart, and a 60 mm upright with 15 mm rounded top corners and a 32 x 12 mm slot for a 25 mm tow strap
let strap_w = 25.0; // [20.0, 50.0] Tow strap width (mm)
let upright_h = 60.0; // [45.0, 90.0] Upright height (mm)
let bolt_spacing = 50.0; // [40.0, 70.0] Bolt spacing (mm)
let thickness = 6.0; // [4.0, 10.0] Plate thickness (mm)
const depth = 40.0;
let w = max(bolt_spacing + 30.0, strap_w + 30.0);
let base = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, depth, thickness]);
let up = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, thickness, upright_h]);
let up = up.fillet(14.0, up.edges("|Y and >Z"));
let body = base + up;
let sw = strap_w + 7.0;
let cuts = [box_centered(sw - 12.0, thickness + 2.0, 12.0).translate([0, thickness / 2.0, upright_h - 20.0]),
    cylinder([-(sw - 12.0) / 2.0, -1.0, upright_h - 20.0], "Y", 6.0, thickness + 2.0),
    cylinder([(sw - 12.0) / 2.0, -1.0, upright_h - 20.0], "Y", 6.0, thickness + 2.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * bolt_spacing / 2.0, depth / 2.0 + thickness / 2.0, -1.0], "Z", 5.25, thickness + 2.0));
}
body - fuse_all(cuts)
