// Petal bead cap for an 8 mm bead: 0.4 mm thick spherical cap 8.4 mm across, eight scalloped petals and a 1.2 mm centre hole
let bead_diameter = 8.0; // [4.0, 16.0] Bead diameter (mm)
let thickness = 0.4; // [0.25, 0.8] Metal thickness (mm)
let petals = 8; // [5, 12] Number of petals
let hole = 1.2; // [0.6, 2.0] Centre hole diameter (mm)
let ri = bead_diameter / 2.0 + 0.05;
let ro = ri + thickness;
let zr = ri * 0.35;
let cap = (sphere(ro) - sphere(ri)) & box_from_corners([-ro - 1.0, -ro - 1.0, zr], [ro + 1.0, ro + 1.0, ro + 1.0]);
let rim = (ri * ri - zr * zr).sqrt();
let cuts = [];
for i in 0..petals {
    let a = (i.to_float() + 0.5) * 360.0 / petals.to_float();
    cuts.push(cylinder([rim + 0.2, 0, zr - 1.0], "Z", rim * 2.0 * PI() / petals.to_float() * 0.3, 1.0 + ri * 0.3).rotate_z(a));
}
cap = cap - compound(cuts);
cap - cylinder([0, 0, ri - 1.0], "Z", hole / 2.0, 3.0)
