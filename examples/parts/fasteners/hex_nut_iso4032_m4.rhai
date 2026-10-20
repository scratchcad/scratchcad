// Hex nut ISO 4032 M4: 7 mm across flats, 3.2 mm tall, 30 deg chamfer both sides, 3.24 mm bore with small countersinks, internal thread rings at 0.7 mm pitch
let diameter = 4.0; // [2.0, 12.0] Thread size (mm)
let across_flats = 7.0; // [4.0, 19.0] Across flats (mm)
let height = 3.2; // [1.6, 10.8] Nut height (mm)
let pitch = 0.7; // [0.4, 1.75] Thread pitch (mm)
let s = max(across_flats, diameter * 1.4);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(height);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.1 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, 0], [rw, 0, 0], [rc + 0.1, 0, dz], [rc + 0.1, 0, height - dz], [rw, 0, height], [0, 0, height]]).to_face().revolve("Z", 360);
let nut = hex & crown;
let r = diameter / 2.0;
let rm = r - 0.541 * pitch;
let p = [[0.0, 0.0, -0.5], [r + 0.3, 0.0, -0.5], [rm, 0.0, r + 0.3 - rm - 0.5]];
let z = r + 0.3 - rm - 0.5;
while z + pitch < height - 0.3 {
    p.push([r, 0.0, z + pitch * 0.45]);
    p.push([r, 0.0, z + pitch * 0.55]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([rm, 0.0, height - 0.3]);
p.push([r + 0.3, 0.0, height + 0.01]);
p.push([r + 0.3, 0.0, height + 0.5]);
p.push([0.0, 0.0, height + 0.5]);
nut - polygon(p).to_face().revolve("Z", 360)
