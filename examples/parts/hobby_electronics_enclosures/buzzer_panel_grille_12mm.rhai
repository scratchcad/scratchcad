// Panel grille holder for a 12 mm active buzzer (12 x 9.5 mm) in a 14 mm hole: 18 mm front disc 1.5 mm with 4 x 1.6 mm sound holes and a 2 mm centre hole, 13.9 mm sleeve 9 mm deep with 12.2 mm bore, 3 crush ribs, rear lead-out slot
let buzzer_d = 12.0; // [9.0, 23.0] Buzzer diameter (mm)
let buzzer_h = 9.5; // [5.0, 14.0] Buzzer height (mm)
let front_d = 18.0; // [14.0, 30.0] Front disc diameter (mm)
let front_t = 1.5; // [1.0, 2.5] Front thickness (mm)
let sound_holes = 4; // [0, 8] Number of sound holes
let rb = buzzer_d / 2.0 + 0.1;
let rs = rb + 0.85;
let rf = max(front_d / 2.0, rs + 1.5);
let sleeve_h = buzzer_h - 0.5;
let body = cylinder(rf, front_t) + cylinder([0, 0, front_t - 0.5], "Z", rs, sleeve_h + 0.5);
let body = body - cylinder([0, 0, front_t], "Z", rb, sleeve_h + 1.0);
let parts = [body];
for k in 0..3 {
    parts.push(box_from_corners([rb - 0.25, -0.5, front_t + 1.0], [rb + 0.3, 0.5, front_t + sleeve_h - 0.5]).rotate_z(k.to_float() * 120.0 + 60.0));
}
let cuts = [cylinder([0, 0, -1], "Z", 1.0, front_t + 2.0)];
let rh = min(rb * 0.55, rb - 1.5);
for k in 0..sound_holes {
    let a = k.to_float() * 2.0 * PI() / sound_holes.to_float();
    cuts.push(cylinder([rh * a.cos(), rh * a.sin(), -1], "Z", 0.8, front_t + 2.0));
}
cuts.push(box_from_corners([-1.5, 0, front_t + sleeve_h - 3.0], [1.5, rs + 1.0, front_t + sleeve_h + 1.0]));
fuse_all(parts) - compound(cuts)
