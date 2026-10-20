// Baby change table hinge end cap: snap cap 38 mm round and 14 mm tall with a 3.8 mm wall, 1.5 mm chamfered top edge, a 30 mm socket 10 mm deep over the hinge pin boss, and three 1 mm snap bumps inside the socket
let cap_d = 38.0; // [26.0, 55.0] Cap diameter (mm)
let cap_h = 14.0; // [8.0, 22.0] Cap height (mm)
let boss_d = 30.0; // [18.0, 45.0] Hinge boss diameter (mm)
let bumps = 3; // [2, 6] Number of snap bumps
const top = 3.0;
let ro = cap_d / 2.0;
let rs = min(boss_d / 2.0 + 0.2, ro - 2.0);
let depth = cap_h - top;
let cap = cylinder([0, 0, 0], "Z", ro, cap_h);
let cap = cap.chamfer(1.5, cap.edges(">Z"));
let body = cap - cylinder([0, 0, -1.0], "Z", rs, depth + 1.0);
let parts = [body];
for i in 0..bumps {
    parts.push(box_from_corners([rs - 1.0, -2.0, 1.5], [rs + 0.5, 2.0, 3.5]).rotate_z(i.to_float() * 360.0 / bumps.to_float()));
}
fuse_all(parts)
