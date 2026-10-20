// Hex head screw ISO 4017 M8 x 30, fully threaded: 13 mm across flats, 5.3 mm head with 30 deg corner chamfer and washer face, 1.25 mm pitch thread rings
let diameter = 8.0; // [4.0, 24.0] Nominal diameter (mm)
let length = 30.0; // [8.0, 150.0] Length under head (mm)
let pitch = 1.25; // [0.5, 3.0] Thread pitch (mm)
let across_flats = 13.0; // [7.0, 36.0] Across flats (mm)
let head_height = 5.3; // [2.8, 15.0] Head height (mm)
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let s = max(across_flats, diameter * 1.4);
let rings = ((length - pitch) / pitch).floor().to_int();
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
for i in 0..rings {
    let z = i.to_float() * pitch;
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
}
p.push([r, 0.0, rings.to_float() * pitch + (r - rm)]);
p.push([r, 0.0, length + 0.01]);
p.push([0.0, 0.0, length + 0.01]);
let shank = polygon(p).to_face().revolve("Z", 360);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(head_height).translate([0, 0, length]);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, length], [rw, 0, length], [rc + 0.2, 0, length + 0.4], [rc + 0.2, 0, length + head_height - dz], [rw, 0, length + head_height], [0, 0, length + head_height]]).to_face().revolve("Z", 360);
shank + (hex & crown)
