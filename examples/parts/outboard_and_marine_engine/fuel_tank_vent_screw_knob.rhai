// Portable outboard fuel tank vent screw: 30 mm knob 12 mm tall with twelve 2 mm grip flutes and a 1 mm top chamfer, an M10 vent stem 15 mm long under it (thread shown plain) with a 0.5 mm tip chamfer, a 2 mm vent bore up the stem breaking out through a 2 mm cross hole under the knob
let knob_d = 30.0; // [20.0, 45.0] Knob diameter (mm)
let knob_h = 12.0; // [8.0, 18.0] Knob height (mm)
let stem_len = 15.0; // [8.0, 25.0] Stem length (mm)
let stem_d = 10.0; // [6.0, 14.0] Stem diameter (mm)
let r = knob_d / 2.0;
let knob = cylinder([0, 0, 0], "Z", r, knob_h);
let knob = knob.chamfer(1.0, knob.edges(">Z"));
let stem = cylinder([0, 0, -stem_len], "Z", stem_d / 2.0, stem_len + 0.5);
let stem = stem.chamfer(0.5, stem.edges("<Z"));
let body = knob + stem;
let cuts = [cylinder([0, 0, -stem_len - 1.0], "Z", 1.0, stem_len - 2.0), cylinder([-stem_d, 0, -4.0], "X", 1.0, 2.0 * stem_d)];
for i in 0..12 {
    cuts.push(cylinder([r + 0.5, 0, -1.0], "Z", 2.0, knob_h - 1.5).rotate_z(i.to_float() * 30.0));
}
body - fuse_all(cuts)
