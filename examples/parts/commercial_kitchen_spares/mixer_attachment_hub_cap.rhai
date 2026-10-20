// Planetary mixer #12 attachment hub cover: 70 mm cap 6 mm thick with a 50 mm spigot 12 mm long that seats in the hub, a 3 mm locating key and a 40 x 10 mm thumb grip bar on the face
let cap_d = 70.0; // [58.0, 90.0] Cap diameter (mm)
let spigot_d = 50.0; // [40.0, 54.0] Spigot diameter (mm)
let spigot_l = 12.0; // [6.0, 20.0] Spigot length (mm)
const cap_t = 6.0;
let spigot = cylinder([0, 0, -spigot_l], "Z", spigot_d / 2.0, spigot_l + 0.01) - cylinder([0, 0, -spigot_l - 1.0], "Z", spigot_d / 2.0 - 3.0, spigot_l);
let key = box_from_corners([spigot_d / 2.0 - 1.0, -1.5, -spigot_l], [spigot_d / 2.0 + 3.0, 1.5, 0.01]);
let cap = cylinder([0, 0, 0], "Z", cap_d / 2.0, cap_t);
cap = cap.chamfer(1.0, cap.edges(">Z"));
let grip = box_centered(40.0, 10.0, 12.0);
grip = grip.fillet(4.0, grip.edges("|Y and >Z"));
cap + spigot + key + grip.translate([0, 0, cap_t + 5.99])
