// Hose bib vacuum breaker, 3/4 in GHT (1-1/16 in-11.5): 34 mm knurled female swivel inlet, 28 mm body with 4 x 5 mm vent ports, 27 mm male hose outlet, 12 mm waterway
let nut_d = 34.0; // [30.0, 40.0] Inlet nut diameter (mm)
let body_d = 28.0; // [24.0, 34.0] Body diameter (mm)
let body_h = 22.0; // [15.0, 35.0] Body height (mm)
let waterway = 12.0; // [8.0, 16.0] Waterway diameter (mm)
let vent_d = 5.0; // [3.0, 7.0] Vent port diameter (mm)
const pitch = 2.209;
const major = 13.45;
const minor = 12.7;
let pts = [[0, 0, 0], [minor - 0.3, 0, 0]];
for i in 0..5 {
    let z0 = 0.5 + i.to_float() * pitch;
    pts.push([major, 0, z0 + 0.35 * pitch]);
    pts.push([major, 0, z0 + 0.65 * pitch]);
    pts.push([minor, 0, z0 + pitch]);
}
const zb = 12.0;
let zn = zb + body_h;
pts.push([minor, 0, zb]);
pts.push([body_d / 2.0, 0, zb]);
pts.push([body_d / 2.0, 0, zn + 0.5]);
pts.push([0, 0, zn + 0.5]);
let body = polygon(pts).to_face().revolve("Z", 360);
let nut = cylinder([0, 0, zn], "Z", nut_d / 2.0, 16.0) - cylinder([0, 0, zn + 2.5], "Z", 13.5, 16.0);
let knurl = [];
for i in 0..24 { knurl.push(box_from_corners([nut_d / 2.0 - 0.4, -0.7, zn + 1.0], [nut_d / 2.0 + 0.8, 0.7, zn + 15.0]).rotate_z(i.to_float() * 15.0)); }
let vents = cylinder([-body_d, 0, zb + body_h * 0.5], "X", vent_d / 2.0, 2.0 * body_d) + cylinder([0, -body_d, zb + body_h * 0.5], "Y", vent_d / 2.0, 2.0 * body_d);
body + nut + fuse_all(knurl) - cylinder([0, 0, -1], "Z", waterway / 2.0, zn + 4.0) - vents
