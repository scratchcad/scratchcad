// MC4 female PV connector housing: 9.8 mm socket insertion end with two latch windows, 17 mm body, 16 mm gland nut with grip flats, 6 mm cable bore, about 57 mm long
let socket_d = 9.8; // [8.0, 12.0] Socket diameter (mm)
let body_d = 17.0; // [14.0, 20.0] Body diameter (mm)
let length = 57.0; // [45.0, 70.0] Overall length (mm)
let cable_d = 6.0; // [4.0, 8.0] Cable bore (mm)
let rs = socket_d / 2.0;
let rb = body_d / 2.0;
let zn = length - 18.0;
let prof = polygon([[0, 0, 0], [rs + 1.6, 0, 0], [rs + 1.6, 0, 16.0], [rb - 1.0, 0, 18.0], [rb, 0, 20.0], [rb, 0, zn - 0.5],
                    [rb - 1.0, 0, zn - 0.5], [rb - 1.0, 0, zn], [rb - 0.5, 0, zn], [rb - 0.5, 0, length - 2.0], [rb - 2.5, 0, length], [0, 0, length]]);
let b = prof.to_face().revolve("Z", 360);
let flats = box_centered(body_d + 2.0, body_d - 2.0, 18.0).translate([0, 0, zn + 9.0]);
let nut_cut = box_centered(body_d * 2.0, body_d * 2.0, 18.5).translate([0, 0, zn + 9.25]) - flats;
b -= nut_cut;
let grip = [];
for i in 0..6 { grip.push(box_centered(1.2, body_d + 2.0, 12.0).translate([0, 0, 27.0]).rotate_z(i.to_float() * 30.0)); }
b -= fuse_all(grip) - cylinder([0, 0, 20.0], "Z", rb - 0.6, 15.0);
b -= cylinder([0, 0, -1], "Z", rs, 22.0);
b -= cylinder([0, 0, 15.0], "Z", 2.0, length);
b -= cylinder([0, 0, zn - 3.0], "Z", cable_d / 2.0, 25.0);
for s in [-1.0, 1.0] { b -= box_centered(4.0, 4.0, 3.5).translate([0, s * (rs + 1.0), 9.0]); }
b
