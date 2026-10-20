// Steering quick release weld-on boss: 40 mm round body 30 mm long with a 20 mm column bore 25 mm deep, topped by a 24 mm across-flats hex spigot 25 mm long with a 3 mm wide, 1.5 mm deep detent ball groove 8 mm below the end and a 1 mm lead-in chamfer
let hex_af = 24.0; // [17.0, 27.0] Hex size across flats (mm)
let spigot_len = 25.0; // [18.0, 35.0] Hex spigot length (mm)
let column_d = 20.0; // [16.0, 25.0] Column diameter (mm)
let body_len = 30.0; // [26.0, 50.0] Body length (mm)
const body_d = 40.0;
let rc = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, spigot_len + 1.0]).translate([0, 0, body_len - 1.0]);
let hex = hex.chamfer(1.0, hex.edges(">Z"));
let body = cylinder([0, 0, 0], "Z", body_d / 2.0, body_len);
let body = body.chamfer(1.0, body.edges("<Z"));
let part = body + hex;
let zg = body_len + spigot_len - 8.0;
let groove = cylinder([0, 0, zg - 1.5], "Z", rc + 2.0, 3.0) - cylinder([0, 0, zg - 2.5], "Z", hex_af / 2.0 - 1.5, 5.0);
let bore = cylinder([0, 0, -1.0], "Z", column_d / 2.0 + 0.1, min(25.0, body_len - 4.0) + 1.0);
part - groove - bore
