// Hex nut DIN 934 M12: 19 mm across flats, 10 mm tall, 30 deg double chamfer, 10.1 mm bore with 120 deg countersinks
let diameter = 12.0; // [3.0, 36.0] Thread size (mm)
let across_flats = 19.0; // [5.5, 55.0] Across flats (mm)
let height = 10.0; // [2.4, 29.0] Nut height (mm)
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
let rm = diameter * 0.845 / 2.0;
let cs = (diameter / 2.0 - rm) * (30.0 * PI() / 180.0).tan() + 0.3;
nut - cylinder([0, 0, -1], "Z", rm, height + 2.0) - cone(diameter / 2.0 + 0.3, rm - 0.01, cs).translate([0, 0, -0.01]) - cone(rm - 0.01, diameter / 2.0 + 0.3, cs).translate([0, 0, height - cs + 0.01])
