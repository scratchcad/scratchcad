// Thin hex jam nut ISO 4035 M10: 16 mm across flats, 5 mm tall, 30 deg chamfer both sides, 8.4 mm bore with countersinks
let diameter = 10.0; // [3.0, 36.0] Thread size (mm)
let across_flats = 16.0; // [5.5, 55.0] Across flats (mm)
let height = 5.0; // [1.8, 18.0] Nut height (mm)
let s = max(across_flats, diameter * 1.4);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(height);
let rw = s * 0.95 / 2.0;
let dz = min((rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan(), height * 0.3);
let crown = polygon([[0, 0, 0], [rw, 0, 0], [rc + 0.2, 0, dz], [rc + 0.2, 0, height - dz], [rw, 0, height], [0, 0, height]]).to_face().revolve("Z", 360);
let nut = hex & crown;
let rm = diameter * 0.84 / 2.0;
let profile = polygon([[0, 0, -0.5], [diameter / 2.0 + 0.5, 0, -0.5], [rm, 0, diameter / 2.0 + 0.5 - rm - 0.5], [rm, 0, height - (diameter / 2.0 + 0.5 - rm - 0.5)], [diameter / 2.0 + 0.5, 0, height + 0.5], [0, 0, height + 0.5]]);
nut - profile.to_face().revolve("Z", 360)
