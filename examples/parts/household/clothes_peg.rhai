// Clothes peg: two 72 x 10 x 7 mm jaws with grip notches and a 4.5 mm torsion spring pocket, spring as a torus
let length = 72.0; // [50.0, 100.0] Jaw length (mm)
let width = 10.0; // [6.0, 15.0] Jaw width (mm)
let jaw_t = 7.0; // [4.0, 10.0] Jaw thickness (mm)
let jaw = sketch("XZ").move_to(0, 0).hline_to(length).vline_to(jaw_t * 0.6).line_to(length * 0.55, jaw_t).line_to(length * 0.35, jaw_t).line_to(0, jaw_t * 0.5).close().to_face().extrude([0, width, 0]);
jaw = jaw - cylinder([length * 0.45, -1, jaw_t + 1.2], "Y", 2.5, width + 2.0);
for k in 0..3 { jaw -= box_from_corners([3.0 + k.to_float() * 4.0, -1, -1], [4.5 + k.to_float() * 4.0, width + 1, 0.8]); }
let lower = jaw.mirror("XY");
let spring = torus(3.0, 0.6).rotate_x(90).translate([length * 0.45, width / 2.0, 0]);
[jaw.translate([0, 0, 0.4]), lower.translate([0, 0, -0.4]), spring]
