// Needle clamp thumb screw: 10 mm knurled-style head 6 mm tall with 12 grip flutes, 0.5 mm chamfers, M4 shank (plain 4 mm cylinder) 8 mm long with a 0.4 mm lead-in chamfer
let head_d = 10.0; // [8.0, 14.0] Head diameter (mm)
let head_h = 6.0; // [4.0, 9.0] Head height (mm)
let shank_d = 4.0; // [3.0, 5.0] Shank diameter (mm)
let shank_len = 8.0; // [5.0, 14.0] Shank length (mm)
let flutes = 12; // [8, 20] Number of grip flutes
let r = head_d / 2.0;
let head = cylinder([0, 0, shank_len], "Z", r, head_h);
let head = head.chamfer(0.5, head.edges(">Z or <Z"));
let shank = cylinder([0, 0, 0], "Z", shank_d / 2.0, shank_len + 0.5);
let shank = shank.chamfer(0.4, shank.edges("<Z"));
let cuts = [];
let fr = min(0.6, PI() * r / flutes.to_float() * 0.4);
for i in 0..flutes {
    let a = i.to_float() * 360.0 / flutes.to_float() * PI() / 180.0;
    cuts.push(cylinder([r * cos(a), r * sin(a), shank_len - 1.0], "Z", fr, head_h + 2.0));
}
(head + shank) - fuse_all(cuts)
