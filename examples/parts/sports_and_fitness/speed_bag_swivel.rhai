// Speed bag swivel: 100 mm mounting disc 8 mm thick with four 6.5 mm bolt holes on 80 mm, 30 mm boss 15 mm tall, 12 mm stem 45 mm long ending in a 28 mm eye 6 mm thick with a 12 mm hook hole
let disc_d = 100.0; // [70.0, 140.0] Mounting disc diameter (mm)
let disc_t = 8.0; // [5.0, 12.0] Disc thickness (mm)
let bolt_circle = 80.0; // [50.0, 120.0] Bolt circle (mm)
let stem_d = 12.0; // [8.0, 16.0] Stem diameter (mm)
let stem_length = 45.0; // [25.0, 80.0] Stem length (mm)
let eye_d = 28.0; // [20.0, 40.0] Eye outer diameter (mm)
const boss_d = 30.0;
const boss_h = 15.0;
const eye_t = 6.0;
let r = disc_d / 2.0;
let disc = cylinder([0, 0, -disc_t], "Z", r, disc_t).chamfer(1.0, "<Z");
let boss = cylinder([0, 0, -disc_t - boss_h], "Z", boss_d / 2.0, boss_h + 0.5).chamfer(1.5, "<Z");
let z_end = -disc_t - boss_h - stem_length;
let stem = cylinder([0, 0, z_end + eye_d / 2.0 - 2.0], "Z", stem_d / 2.0, stem_length - eye_d / 2.0 + 2.5);
let ed = max(eye_d, stem_d + 8.0);
let eye = cylinder([0, -eye_t / 2.0, z_end], "Y", ed / 2.0, eye_t) - cylinder([0, -eye_t, z_end], "Y", min(12.0, ed - 8.0) / 2.0, 2.0 * eye_t);
let swivel = fuse_all([disc, boss, stem, eye]);
let bc = min(bolt_circle, disc_d - 14.0) / 2.0;
for i in 0..4 {
    let a = (i.to_float() * 90.0 + 45.0) * PI() / 180.0;
    swivel = swivel - cylinder([bc * a.cos(), bc * a.sin(), -disc_t - 1.0], "Z", 3.25, disc_t + 2.0);
}
swivel
