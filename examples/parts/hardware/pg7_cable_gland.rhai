// PG7 cable gland: 12.5 mm thread 8 mm long, 15 mm hex body, domed cap nut 15 mm AF, cable range 3-6.5 mm
let thread_d = 12.5; // [9.0, 30.0] Thread diameter (mm)
let thread_l = 8.0; // [5.0, 15.0] Thread length (mm)
let across_flats = 15.0; // [12.0, 40.0] Hex size (mm)
let body_h = 5.0; // [3.0, 10.0] Hex height (mm)
let cap_h = 12.0; // [8.0, 25.0] Cap height (mm)
let cable_max = 6.5; // [3.0, 13.2] Largest cable (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face();
let body = hex.extrude(body_h) + cylinder([0, 0, -thread_l], "Z", thread_d / 2.0, thread_l + 0.01);
let cap = (hex.extrude(cap_h * 0.5).translate([0, 0, body_h + 0.5]) + cone(across_flats / 2.0 * 0.95, cable_max / 2.0 + 1.5, cap_h * 0.5).translate([0, 0, body_h + 0.5 + cap_h * 0.5 - 0.01]));
let bore = cylinder([0, 0, -thread_l - 1], "Z", cable_max / 2.0, thread_l + body_h + cap_h + 3.0);
[body - bore, cap - bore]
