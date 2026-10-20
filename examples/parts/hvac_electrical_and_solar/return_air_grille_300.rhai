// Fixed-blade return air grille for a 12 x 12 in (305 mm) opening: 355 mm square face, 32 mm border, 45 degree deflection blades on 15 mm pitch, 40 mm deep sleeve, four screw holes
let opening = 305.0; // [150.0, 600.0] Duct opening size (mm)
let border = 25.0; // [15.0, 40.0] Face border width (mm)
let pitch = 15.0; // [10.0, 25.0] Blade pitch (mm)
let blade_angle = 45.0; // [20.0, 60.0] Blade angle (degrees)
const t = 1.2;
const sleeve = 40.0;
let face = opening + 2.0 * border;
let o = opening - 2.0 * t;
let frame = box_centered(face, face, t * 2.0).translate([0, 0, t]) - box_centered(o, o, 10.0);
frame = frame.chamfer(t, ">Z");
let sl = box_centered(opening, opening, sleeve).translate([0, 0, -sleeve / 2.0 + 0.5]) - box_centered(o, o, sleeve + 4.0).translate([0, 0, -sleeve / 2.0]);
let n = (o / pitch).floor().to_int();
let blades = [];
let bw = pitch / (blade_angle * PI() / 180.0).sin() * 1.1;
for i in 0..n {
    let y = -o / 2.0 + pitch * (i.to_float() + 0.5);
    blades.push(box_centered(o + 1.0, bw, t).rotate_x(blade_angle).translate([0, y, -bw * 0.4]));
}
let bl = fuse_all(blades) & box_centered(o + 0.5, o, sleeve).translate([0, 0, -sleeve / 2.0 + t]);
let g = fuse_all([frame, sl, bl]);
for x in [-1.0, 1.0] { g -= cylinder([x * (face / 2.0 - border / 2.0), 0, -1], "Z", 2.5, 5.0); g -= cylinder([0, x * (face / 2.0 - border / 2.0), -1], "Z", 2.5, 5.0); }
g
