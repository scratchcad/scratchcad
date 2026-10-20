// Schrader tyre valve dust cap: 8V1 thread (7.7 mm major, 32 TPI), 9.6 mm knurled cap 10.5 mm tall, 24 grip ribs, domed top
let cap_d = 9.6; // [8.5, 12.0] Cap diameter (mm)
let cap_height = 10.5; // [8.0, 14.0] Cap height (mm)
let bore_d = 7.0; // [6.5, 7.7] Thread minor bore (mm)
let bore_depth = 7.5; // [5.0, 10.0] Bore depth (mm)
let ribs = 24; // [12, 36] Number of grip ribs
const rib_w = 0.6;
let body = cylinder(cap_d / 2.0, cap_height).fillet(1.0, ">Z");
let grooves = [];
for i in 0..ribs {
    grooves.push(box_centered(rib_w, 1.0, cap_height - 2.5).translate([0, cap_d / 2.0 + 0.1, (cap_height - 2.5) / 2.0 - 0.01]).rotate_z(i.to_float() * 360.0 / ribs.to_float()));
}
let cap = body - compound(grooves);
let bore = cylinder([0, 0, -1.0], "Z", bore_d / 2.0, bore_depth + 1.0);
let ridges = [];
for k in 0..6 { ridges.push(cylinder([0, 0, 1.0 + k.to_float() * 0.8], "Z", bore_d / 2.0 + 0.3, 0.35)); }
cap - bore - compound(ridges)
