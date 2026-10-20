// Aquaponics media bed bell siphon top cap: push-on cap for a 75 mm OD bell pipe with a 3 mm top 81.6 mm across, a 25 mm skirt 3 mm thick with four 8 mm grip ribs, and a 13 mm snorkel socket 15 mm tall off-centre for the air-break tube
let pipe_od = 75.0; // [50.0, 110.0] Bell pipe outside diameter (mm)
let skirt = 25.0; // [15.0, 40.0] Skirt depth (mm)
let snorkel_d = 13.0; // [8.0, 20.0] Snorkel tube outside diameter (mm)
const t = 3.0;
const clear = 0.3;
let ri = pipe_od / 2.0 + clear;
let ro = ri + t;
let cap = cylinder([0, 0, 0], "Z", ro, skirt + t) - cylinder([0, 0, -1.0], "Z", ri, skirt + 1.0);
let ribs = [];
for i in 0..4 {
    ribs.push(box_from_corners([ro - 1.0, -4.0, 2.0], [ro + 2.0, 4.0, skirt + t - 2.0]).rotate_z(i.to_float() * 90.0 + 45.0));
}
let sr = snorkel_d / 2.0 + 2.0;
let sx = ri - sr - 4.0;
let sock = cylinder([sx, 0, skirt + t - 0.5], "Z", sr, 15.5);
let bore = cylinder([sx, 0, skirt - 1.0], "Z", snorkel_d / 2.0 + 0.2, 20.0);
fuse_all([cap, sock] + ribs) - bore
