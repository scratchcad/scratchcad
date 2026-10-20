// Olympic barbell sleeve end cap: 50 mm cap 6 mm thick with a 1 mm chamfer and a 40 mm decorative groove, 30 mm locating spigot 12 mm long, M8 countersunk retaining screw hole
let cap_d = 50.0; // [45.0, 52.0] Cap diameter (mm)
let cap_t = 6.0; // [4.0, 10.0] Cap thickness (mm)
let spigot_d = 30.0; // [20.0, 40.0] Spigot diameter (mm)
let spigot_length = 12.0; // [5.0, 20.0] Spigot length (mm)
let screw_d = 8.4; // [5.0, 10.0] Screw hole (mm)
let r = cap_d / 2.0;
let cap = cylinder(r, cap_t).chamfer(1.0, ">Z") + cylinder([0, 0, -spigot_length], "Z", min(spigot_d, cap_d - 6.0) / 2.0, spigot_length + 0.5);
cap = cap - (cylinder([0, 0, cap_t - 0.6], "Z", r * 0.8, 1.0) - cylinder([0, 0, cap_t - 1.0], "Z", r * 0.8 - 1.0, 2.0));
cap - cylinder([0, 0, -spigot_length - 1.0], "Z", screw_d / 2.0, spigot_length + cap_t + 2.0) - cone(screw_d / 2.0, screw_d / 2.0 + 4.0, 4.0).translate([0, 0, cap_t - 3.99])
