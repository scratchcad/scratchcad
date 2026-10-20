// Bale spear tine mounting sleeve: 55 mm hex 45 mm long with its corners turned to 58 mm, a 4 mm thick 70 mm flange at the front, and a tapered bore 36 mm at the front narrowing to 30 mm at the back to seat the conical root of a Euro bale spear tine
let hex_af = 55.0; // [40.0, 70.0] Hex across flats (mm)
let length = 45.0; // [30.0, 60.0] Sleeve length (mm)
let bore_front = 36.0; // [26.0, 46.0] Bore at the front (mm)
let bore_back = 30.0; // [20.0, 40.0] Bore at the back (mm)
let flange_d = 70.0; // [50.0, 90.0] Flange diameter (mm)
const flange_t = 4.0;
let rh = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let turned = hex_af / 2.0 + (rh - hex_af / 2.0) * 0.4;
let hex = polygon([30, 90, 150, 210, 270, 330].map(|a| [rh * cos(a * PI() / 180.0), rh * sin(a * PI() / 180.0), 0])).to_face().extrude([0, 0, length]);
let hex = hex & cylinder([0, 0, -1.0], "Z", turned, length + 2.0);
let rf = max(flange_d / 2.0, rh + 2.0);
let body = hex + cylinder([0, 0, length - flange_t], "Z", rf, flange_t);
let rfb = min(bore_front / 2.0, hex_af / 2.0 - 4.0);
let rbb = min(bore_back / 2.0, rfb);
let k = (rfb - rbb) / length;
let bore = if k > 0.001 {
    cone(rbb - k, rfb + k, length + 2.0).translate([0, 0, -1.0])
} else {
    cylinder([0, 0, -1.0], "Z", rbb, length + 2.0)
};
body - bore
