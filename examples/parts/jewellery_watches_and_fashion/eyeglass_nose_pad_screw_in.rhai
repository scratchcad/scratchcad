// Screw-in eyeglass nose pad: 13 x 7 mm oval pad 1.6 mm thick with a crowned face, and a 1.0 x 1.6 x 2.8 mm box stem with a 1.0 mm screw hole for the pad arm
let pad_length = 13.0; // [9.0, 17.0] Pad length (mm)
let pad_width = 7.0; // [5.0, 10.0] Pad width (mm)
let pad_thickness = 1.6; // [1.0, 2.5] Pad thickness (mm)
let stem_height = 2.8; // [2.0, 4.0] Stem height (mm)
let screw_hole = 1.0; // [0.7, 1.3] Screw hole diameter (mm)
let pts = [];
for i in 0..32 {
    let t = i.to_float() * 2.0 * PI() / 32.0;
    // slightly teardrop: wider at the bottom (-X)
    let w = pad_width / 2.0 * (1.0 - 0.12 * t.cos());
    pts.push([pad_length / 2.0 * t.cos(), w * t.sin(), 0]);
}
let pad = face(wire([spline(pts, true)])).extrude([0, 0, pad_thickness]);
// crown the face with a large sphere
const crown_r = 25.0;
pad = pad & sphere([0, 0, pad_thickness - crown_r], crown_r);
let stem = box_centered(1.0, 1.6, stem_height + 0.3).translate([0, 0, -stem_height / 2.0 + 0.15]);
stem = stem - cylinder([-1.5, 0, -stem_height + 1.0], "X", screw_hole / 2.0, 3.0);
pad + stem
