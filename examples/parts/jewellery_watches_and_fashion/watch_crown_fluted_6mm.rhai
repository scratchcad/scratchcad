// Fluted watch crown, 6 mm diameter x 3.6 mm tall: domed top, 20 grip flutes, 3 mm recess for the 2.5 mm tube and a 0.9 mm (tap 0.9) stem hole
let crown_diameter = 6.0; // [4.0, 9.0] Crown diameter (mm)
let crown_height = 3.6; // [2.5, 5.0] Crown height (mm)
let flutes = 20; // [0, 32] Grip flutes
let recess_diameter = 3.0; // [2.0, 4.0] Tube recess diameter (mm)
let recess_depth = 2.0; // [1.0, 2.5] Tube recess depth (mm)
let stem_hole = 0.9; // [0.6, 1.2] Stem hole diameter (mm)
let r = crown_diameter / 2.0;
let rr = min(recess_diameter / 2.0, r - 0.6);
let zd = crown_height - 0.6;
let profile = sketch("XZ")
    .move_to(rr, 0)
    .hline_to(r)
    .vline_to(zd)
    .arc_to(r * 0.6, crown_height - 0.12, 0, crown_height)
    .vline_to(min(recess_depth + 1.0, zd - 0.3))
    .hline_to(stem_hole / 2.0)
    .vline_to(recess_depth)
    .hline_to(rr)
    .close();
let crown = profile.to_face().revolve("Z", 360);
let cuts = [];
for i in 0..flutes {
    cuts.push(cylinder([r + 0.12, 0, 0.35], "Z", 0.3, crown_height).rotate_z(i.to_float() * 360.0 / flutes.to_float()));
}
if flutes > 0 { crown = crown - compound(cuts); }
crown
