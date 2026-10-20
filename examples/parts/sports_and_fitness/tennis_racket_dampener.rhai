// Button-style tennis string vibration dampener: 24 mm disc 8 mm thick, domed face, two 1.6 mm string grooves 12 mm apart on the back, 4 mm deep, with snap ridges
let diameter = 24.0; // [16.0, 32.0] Diameter (mm)
let thickness = 8.0; // [5.0, 12.0] Thickness (mm)
let string_gap = 12.0; // [8.0, 16.0] String spacing (mm)
let groove = 1.6; // [1.2, 2.0] String groove width (mm)
let groove_depth = 4.0; // [2.0, 6.0] Groove depth (mm)
let r = diameter / 2.0;
const dome = 2.0;
// spherical dome centred on the axis through the shoulder and the top centre
let shoulder = thickness - dome;
let zc = (r * r + shoulder * shoulder - thickness * thickness) / (2.0 * (shoulder - thickness));
let dome_r = thickness - zc;
let prof = sketch("XZ").move_to(0, 0).hline_to(r - 1.0).arc_to(r - 0.29, 0.29, r, 1.0).vline_to(thickness - dome).arc_to(r * 0.6, zc + sqrt(dome_r * dome_r - 0.36 * r * r), 0, thickness).close();
let damp = prof.to_face().revolve("Z", 360);
let gd = min(groove_depth, thickness - 2.5);
for x in [-string_gap / 2.0, string_gap / 2.0] {
    damp = damp - box_centered(groove, diameter + 2.0, gd * 2.0).translate([x, 0, 0]) - cylinder([x, -r - 1.0, gd], "Y", groove / 2.0 + 0.2, diameter + 2.0);
}
damp
