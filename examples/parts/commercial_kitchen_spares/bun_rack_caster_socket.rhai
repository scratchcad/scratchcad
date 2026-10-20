// Bun pan rack caster socket: plug for 25.4 mm square tube (1.6 mm wall), 30 mm long with three grip ribs per side, 3 mm cap flange and an 11.5 mm bore for a 7/16 in grip-ring caster stem
let tube = 25.4; // [19.0, 32.0] Tube outside size (mm)
let wall = 1.6; // [1.2, 2.0] Tube wall (mm)
let length = 30.0; // [20.0, 40.0] Plug length (mm)
let stem = 11.5; // [8.0, 13.0] Caster stem bore (mm)
const cap_t = 3.0;
let inner = tube - 2.0 * wall;
let body = box_centered(inner - 0.6, inner - 0.6, length).translate([0, 0, length / 2.0]);
let ribs = [];
for i in 0..3 {
    let z = length * (i.to_float() + 1.0) / 4.0;
    ribs.push(box_centered(inner + 0.4, inner + 0.4, 1.5).translate([0, 0, z]));
}
let cap = box_centered(tube, tube, cap_t).translate([0, 0, -cap_t / 2.0 + 0.01]);
cap = cap.fillet(2.0, cap.edges("|Z"));
let s = body + fuse_all(ribs) + cap;
s - cylinder([0, 0, -cap_t - 1.0], "Z", stem / 2.0, length + cap_t - 2.0)
