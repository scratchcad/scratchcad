// Cabinet levelling foot: 50 mm base pad 10 mm tall with a 3 mm chamfer, 19 mm across flats hex 8 mm tall for the spanner, M12 threaded stud 50 mm long with a 1 mm end chamfer
let pad_d = 50.0; // [30.0, 80.0] Pad diameter (mm)
let stud_len = 50.0; // [25.0, 100.0] Stud length (mm)
let pad_h = 10.0; // [6.0, 16.0] Pad height (mm)
const hex_af = 19.0;
const hex_h = 8.0;
const stud_d = 12.0;
let r = pad_d / 2.0;
let pad = face(polygon([[0, 0, 0], [r, 0, 0], [r, 0, pad_h - 3.0], [r - 3.0, 0, pad_h], [0, 0, pad_h]])).revolve("Z", 360.0);
let rh = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rh * cos(a), rh * sin(a), pad_h]);
}
let hex = face(polygon(pts)).extrude([0, 0, hex_h]);
let stud = cylinder([0, 0, pad_h + hex_h - 0.5], "Z", stud_d / 2.0, stud_len + 0.5);
let stud = stud.chamfer(1.0, stud.edges(">Z"));
pad + hex + stud
