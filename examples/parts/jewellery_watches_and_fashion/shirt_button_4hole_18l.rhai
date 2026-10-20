// Shirt button, 18 ligne (11.43 mm) with four 1.6 mm holes on a 2.6 mm square, 2.2 mm rim dished to 1.4 mm at the centre
let diameter = 11.43; // [9.0, 25.0] Button diameter (mm)
let thickness = 2.2; // [1.5, 4.0] Rim thickness (mm)
let dish = 0.8; // [0.2, 1.2] Dish depth (mm)
let hole_diameter = 1.6; // [1.0, 2.5] Hole diameter (mm)
let hole_spacing = 2.6; // [2.0, 6.0] Hole spacing (mm)
let r = diameter / 2.0;
let d = min(dish, thickness - 0.6);
let profile = sketch("XZ")
    .move_to(0, 0)
    .hline_to(r - 0.4)
    .arc_to(r, thickness / 2.0, r - 0.4, thickness)
    .line_to(r - 1.2, thickness)
    .arc_to((r - 1.2) * 0.5, thickness - d * 0.9, 0, thickness - d)
    .close();
let button = profile.to_face().revolve("Z", 360);
let s = min(hole_spacing, (r - 1.2) * 1.2) / 2.0;
let holes = [];
for p in [[s, s], [-s, s], [-s, -s], [s, -s]] {
    holes.push(cylinder([p[0], p[1], -1], "Z", hole_diameter / 2.0, thickness + 2.0));
}
button - compound(holes)
