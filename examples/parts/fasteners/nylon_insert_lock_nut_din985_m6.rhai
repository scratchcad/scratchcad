// Nylon-insert lock nut DIN 985 M6: 10 mm across flats, 6 mm overall height, 30 deg chamfered hex 4.2 mm tall, rolled-over collar holding a 4.9 mm bore nylon ring
let diameter = 6.0; // [3.0, 24.0] Thread size (mm)
let across_flats = 10.0; // [5.5, 36.0] Across flats (mm)
let height = 6.0; // [3.0, 24.0] Overall height (mm)
let hex_height = 4.2; // [2.0, 18.0] Hex part height (mm)
let s = max(across_flats, diameter * 1.4);
let hh = min(hex_height, height - 1.0);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(hh);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, 0], [rw, 0, 0], [rc + 0.2, 0, dz], [rc + 0.2, 0, hh + 1.0], [0, 0, hh + 1.0]]).to_face().revolve("Z", 360);
let rcol = s * 0.9 / 2.0;
let collar = polygon([[diameter * 0.6, 0, hh - 0.01], [rcol, 0, hh - 0.01], [rcol, 0, height - 0.6], [rcol - 0.6, 0, height], [diameter * 0.6, 0, height]]).to_face().revolve("Z", 360);
let body = (hex & crown) + collar;
let rm = diameter * 0.83 / 2.0;
body = body - cylinder([0, 0, -1], "Z", rm, height + 2.0) - cone(diameter / 2.0 + 0.3, rm, diameter / 2.0 + 0.3 - rm).translate([0, 0, -0.01]);
let ring_bore = diameter * 0.82;
let ring = cylinder([0, 0, hh + 0.2], "Z", diameter * 0.6 - 0.02, height - hh - 0.7) - cylinder([0, 0, hh], "Z", ring_bore / 2.0, height);
body = body - cylinder([0, 0, hh + 0.19], "Z", diameter * 0.6, height - hh - 0.68);
compound([body, ring])
