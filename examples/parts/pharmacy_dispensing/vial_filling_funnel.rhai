// Pharmacy vial filling funnel: 70 mm conical mouth 35 mm tall narrowing to a 16 mm throat, with a 6 mm spout inside a 15 mm skirt that sits over a 40 mm dispensing vial, 1.6 mm walls
let vial_d = 40.0; // [30.0, 55.0] Vial outside diameter (mm)
let mouth_d = 70.0; // [55.0, 100.0] Funnel mouth diameter (mm)
let throat_d = 16.0; // [10.0, 24.0] Throat diameter (mm)
let cone_h = 35.0; // [20.0, 50.0] Cone height (mm)
let skirt_h = 15.0; // [10.0, 25.0] Skirt depth (mm)
const t = 1.6;
const spout = 6.0;
let ri = vial_d / 2.0 + 0.4;
let r_out = throat_d / 2.0;
let r_top = max(mouth_d / 2.0, ri + 4.0);
let z_top = skirt_h + t + cone_h;
let profile = polygon([
    [r_out, 0, skirt_h - spout], [r_out + t, 0, skirt_h - spout], [r_out + t, 0, skirt_h],
    [ri, 0, skirt_h], [ri, 0, 0], [ri + t, 0, 0], [ri + t, 0, skirt_h + t],
    [r_top + t, 0, z_top], [r_top, 0, z_top], [r_out, 0, skirt_h + t],
]);
profile.to_face().revolve("Z", 360.0)
