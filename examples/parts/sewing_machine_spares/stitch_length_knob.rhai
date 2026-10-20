// Stitch length knob: 30 mm grip 14 mm tall with 24 grip flutes 1.6 mm wide, raised 2 mm pointer rib on the top, 1 mm top chamfer, 6 mm D bore 10 mm deep with a 4.8 mm flat
let knob_d = 30.0; // [22.0, 40.0] Knob diameter (mm)
let height = 14.0; // [10.0, 20.0] Knob height (mm)
let flutes = 24; // [12, 36] Number of grip flutes
let shaft_d = 6.0; // [4.0, 8.0] Shaft diameter (mm)
const flute_r = 0.8;
const bore_depth = 10.0;
let r = knob_d / 2.0;
let knob = cylinder(r, height);
let knob = knob.chamfer(1.0, knob.edges(">Z"));
let rib = box_from_corners([r * 0.2, -1.0, height - 0.5], [r - 1.5, 1.0, height + 2.0]);
let knob = knob + rib;
let cuts = [];
for i in 0..flutes {
    let a = i.to_float() * 360.0 / flutes.to_float() * PI() / 180.0;
    cuts.push(cylinder([r * cos(a), r * sin(a), -1.0], "Z", flute_r, height - 2.0));
}
let d = cylinder([0, 0, -1.0], "Z", shaft_d / 2.0, bore_depth + 1.0) - box_from_corners([shaft_d * 0.3, -shaft_d, -2.0], [shaft_d, shaft_d, bore_depth + 1.0]);
cuts.push(d);
knob - fuse_all(cuts)
