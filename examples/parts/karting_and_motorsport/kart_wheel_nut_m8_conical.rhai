// Kart wheel nut M8 x 1.25 with a 60 degree conical seat: 13 mm across-flats hex 7 mm tall over a 3 mm cone seat from 13 mm down to 9.5 mm, 6.8 mm tapped core and 0.5 mm top chamfer
let hex_af = 13.0; // [12.0, 17.0] Hex size across flats (mm)
let hex_h = 7.0; // [5.0, 12.0] Hex height (mm)
let bore = 6.8; // [5.0, 8.5] Tapped core diameter (mm)
const seat_h = 3.0;
let rc = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, hex_h]).translate([0, 0, seat_h]);
let crown = cone(rc + 1.5, hex_af / 2.0 - 0.5, 2.0).translate([0, 0, seat_h + hex_h - 2.0]) + cylinder([0, 0, seat_h - 0.5], "Z", rc + 2.0, hex_h - 1.5);
let hex = hex & crown;
let seat = cone(bore / 2.0 + 1.35, hex_af / 2.0, seat_h + 0.5);
let nut = hex + seat;
nut - cylinder([0, 0, -1.0], "Z", bore / 2.0, seat_h + hex_h + 2.0)
