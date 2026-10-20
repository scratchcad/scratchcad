// Mounting plate standoff, hex 13 mm across flats, 25 mm long, M8 tapped through (6.8 mm core) with 1 mm 45 degree chamfered ends, for spacing a cabinet back plate off the rear wall
let length = 25.0; // [10.0, 80.0] Standoff length (mm)
let flats = 13.0; // [10.0, 19.0] Width across flats (mm)
let thread_d = 8.0; // [5.0, 8.0] Thread size (mm)
const c = 1.0;
let r = flats / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, length]);
let rr = r + 0.5;
let chamfer_body = face(polygon([[0, 0, -1.0], [rr - c - 1.0, 0, -1.0], [rr, 0, c], [rr, 0, length - c], [rr - c - 1.0, 0, length + 1.0], [0, 0, length + 1.0]])).revolve("Z", 360.0);
(hex & chamfer_body) - cylinder([0, 0, -1.0], "Z", thread_d * 0.85 / 2.0, length + 2.0)
