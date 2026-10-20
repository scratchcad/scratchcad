// Hex head screw DIN 933 M5 x 16: 8 mm across flats, 3.5 mm head with 30 deg chamfer, plain 5 mm thread cylinder with 0.5 mm tip chamfer
let diameter = 5.0; // [3.0, 20.0] Nominal diameter (mm)
let length = 16.0; // [5.0, 100.0] Length under head (mm)
let across_flats = 8.0; // [5.5, 30.0] Across flats (mm)
let head_height = 3.5; // [2.0, 13.0] Head height (mm)
let r = diameter / 2.0;
let s = max(across_flats, diameter * 1.4);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(head_height).translate([0, 0, length]);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, length], [rc + 0.2, 0, length], [rc + 0.2, 0, length + head_height - dz], [rw, 0, length + head_height], [0, 0, length + head_height]]).to_face().revolve("Z", 360);
let shank = cylinder(r, length + 0.01).chamfer(min(0.5, r * 0.3), "<Z");
shank + (hex & crown)
