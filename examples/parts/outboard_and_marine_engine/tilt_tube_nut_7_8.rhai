// Outboard tilt tube nut for a 7/8 in tilt tube: 1-1/4 in (31.75 mm) across-flats hex 16 mm tall with 30 degree chamfers on both faces, a washer face 3 mm thick and 3 mm wider than the flats, and a 21.3 mm tapped core for 7/8-14 UNF
let hex_af = 31.75; // [25.0, 40.0] Hex size across flats (mm)
let hex_h = 16.0; // [10.0, 24.0] Hex height (mm)
let core_d = 21.3; // [15.0, 26.0] Tapped core diameter (mm)
const washer_t = 3.0;
let rc = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, hex_h]).translate([0, 0, washer_t]);
let r0 = hex_af / 2.0 - 0.8;
let hc = (rc + 1.0 - r0) * tan(30.0 * PI() / 180.0);
let env = face(polygon([[0, 0, washer_t], [r0, 0, washer_t], [rc + 1.0, 0, washer_t + hc], [rc + 1.0, 0, washer_t + hex_h - hc], [r0, 0, washer_t + hex_h], [0, 0, washer_t + hex_h]])).revolve("Z", 360.0);
let hex = hex & env;
let washer = cylinder([0, 0, 0], "Z", min(36.0 / 2.0, hex_af / 2.0 + 1.5), washer_t + 0.5);
let ri = min(core_d / 2.0, hex_af / 2.0 - 3.0);
(hex + washer) - cylinder([0, 0, -1.0], "Z", ri, washer_t + hex_h + 2.0)
