// Roof antenna mast thread adapter M6 male to M5 female: 10 mm AF hex 8 mm tall, 6 mm stud 9 mm long with a 1 mm chamfer, 4.2 mm tapping bore 9 mm deep, 12 mm sealing collar
let hex_af = 10.0; // [8.0, 13.0] Hex across flats (mm)
let hex_h = 8.0; // [5.0, 12.0] Hex height (mm)
let stud_d = 6.0; // [4.0, 8.0] Male stud diameter (mm)
let stud_len = 9.0; // [6.0, 14.0] Stud length (mm)
let tap = 4.2; // [2.5, 5.0] Female tapping bore (mm)

const collar_d = 12.0;
const collar_h = 1.5;
let rc = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = (i * 60.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, hex_h]);
hex = hex & cone(rc + hex_h - 0.6, rc - 0.6, hex_h);
let collar = cylinder([0, 0, -collar_h], "Z", max(collar_d, hex_af + 2.0) / 2.0, collar_h + 0.5);
let stud = cylinder([0, 0, hex_h - 0.5], "Z", stud_d / 2.0, stud_len + 0.5);
stud = stud.chamfer(min(1.0, stud_d / 4.0), stud.edges(">Z"));
let part = fuse_all([hex, collar, stud]);
let td = min(tap, hex_af - 3.0);
part - cylinder([0, 0, -collar_h - 1.0], "Z", td / 2.0, min(9.0, hex_h + collar_h - 1.0) + 1.0)
