// Nib cleaning jar lid: 70 mm push lid with 8 mm skirt for a 66 mm jar, 3 mm top with a 30 mm sponge pocket ring and six 8 mm nib slots around it
let jar = 66.0; // [55.0, 85.0] Jar mouth OD (mm)
let skirt = 8.0; // [5.0, 15.0] Skirt depth (mm)
const t = 3.0;
let lid = cylinder([0, 0, 0], "Z", jar / 2.0 + 2.0, skirt + t) - cylinder([0, 0, -1.0], "Z", jar / 2.0 + 0.3, skirt + 1.0);
let ring = cylinder([0, 0, skirt + t - 0.01], "Z", 17.0, 6.0) - cylinder([0, 0, skirt], "Z", 15.0, 8.0);
let slots = [];
for i in 0..6 { slots.push(box_centered(8.0, 2.0, 10.0).translate([jar * 0.33, 0, skirt + t / 2.0]).rotate_z(i.to_float() * 60.0)); }
lid + ring - fuse_all(slots)
