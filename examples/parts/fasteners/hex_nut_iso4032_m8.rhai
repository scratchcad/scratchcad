// Hex nut ISO 4032 M8: 13 mm across flats, 6.8 mm tall, 30 deg chamfer both sides, 6.65 mm minor-diameter bore with 90 deg countersinks to 8 mm
let diameter = 8.0; // [3.0, 30.0] Thread size (mm)
let across_flats = 13.0; // [5.5, 46.0] Across flats (mm)
let height = 6.8; // [2.4, 26.0] Nut height (mm)
let pitch = 1.25; // [0.5, 3.5] Thread pitch (mm)
let s = max(across_flats, diameter * 1.4);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(height);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, 0], [rw, 0, 0], [rc + 0.2, 0, dz], [rc + 0.2, 0, height - dz], [rw, 0, height], [0, 0, height]]).to_face().revolve("Z", 360);
let nut = hex & crown;
let rm = diameter / 2.0 - 0.541 * pitch;
let cs = diameter / 2.0 - rm + 0.01;
let hole = polygon([[0, 0, -0.5], [rm + cs + 0.5, 0, -0.5], [rm, 0, cs], [rm, 0, height - cs], [rm + cs + 0.5, 0, height + 0.5], [0, 0, height + 0.5]]).to_face().revolve("Z", 360);
nut - hole
