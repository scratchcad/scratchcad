// Aquaponics media guard for a bell siphon: 110 mm OD sleeve 2.5 mm wall, 200 mm tall, with rows of 3 mm horizontal slots 30 mm long (eight per row, rows 10 mm apart) leaving a solid 20 mm band at top and bottom
let od = 110.0; // [75.0, 160.0] Sleeve outside diameter (mm)
let height = 200.0; // [120.0, 300.0] Sleeve height (mm)
let rows = 16; // [6, 26] Number of slot rows
let slot_w = 3.0; // [2.0, 5.0] Slot width (mm)
const wall = 2.5;
const band = 20.0;
let ro = od / 2.0;
let sleeve = cylinder([0, 0, 0], "Z", ro, height) - cylinder([0, 0, -1.0], "Z", ro - wall, height + 2.0);
let pitch = (height - 2.0 * band) / rows.to_float();
let sw = min(slot_w, pitch * 0.5);
let half = min(15.0, ro * 0.3);
let cuts = [];
for j in 0..rows {
    let z = band + pitch * (j.to_float() + 0.5);
    for i in 0..8 {
        cuts.push(box_from_corners([ro - wall - 2.0, -half, z - sw / 2.0], [ro + 2.0, half, z + sw / 2.0]).rotate_z(i.to_float() * 45.0 + (j % 2).to_float() * 22.5));
    }
}
sleeve - fuse_all(cuts)
