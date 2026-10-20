// Food waste disposer splash guard: 85 mm rubber baffle disc 2.5 mm thick with a 6 mm deep, 4 mm wide sealing bead, a 10 mm centre hole and eight 1.2 mm radial slits out to 30 mm forming the flaps
let dia = 85.0; // [70.0, 100.0] Baffle diameter (mm)
let slit_r = 30.0; // [20.0, 32.0] Slit length from centre (mm)
let slits = 8; // [4, 12] Number of slits
const t = 2.5;
let r = dia / 2.0;
let disc = cylinder([0, 0, 0], "Z", r, t) + (cylinder([0, 0, -6.0], "Z", r, 6.01) - cylinder([0, 0, -7.0], "Z", r - 4.0, 8.0));
let cuts = [cylinder([0, 0, -1.0], "Z", 5.0, t + 2.0)];
for i in 0..slits {
    cuts.push(box_from_corners([0, -0.6, -1.0], [slit_r, 0.6, t + 1.0]).rotate_z(i.to_float() * 360.0 / slits.to_float()));
}
disc - fuse_all(cuts)
