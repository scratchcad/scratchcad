// Plenum box spigot collar 150 mm: 149 mm OD tube 60 mm long with 1.5 mm wall, 15 mm base flange split into 16 fold tabs by 3 mm slits, 2 mm gasket bead 20 mm above the flange
let spigot_d = 149.0; // [80.0, 250.0] Spigot outside diameter (mm)
let length = 60.0; // [30.0, 120.0] Spigot length (mm)
let tab_w = 15.0; // [8.0, 25.0] Tab flange width (mm)
let tab_count = 16; // [8, 32] Number of fold tabs
const wall = 1.5;
const flange_t = 1.5;
const slit = 3.0;
let ro = spigot_d / 2.0;
let ri = ro - wall;
let tube = cylinder(ro, length) - cylinder([0, 0, -1], "Z", ri, length + 2.0);
let flange = cylinder(ro + tab_w, flange_t) - cylinder([0, 0, -1], "Z", ri, flange_t + 2.0);
let bead = cylinder([0, 0, 20.0], "Z", ro + 2.0, 2.0) - cylinder([0, 0, 19.0], "Z", ri + 0.5, 4.0);
let slits = [];
for k in 0..tab_count {
    slits.push(box_from_corners([ro + 0.5, -slit / 2.0, -1.0], [ro + tab_w + 1.0, slit / 2.0, flange_t + 1.0]).rotate_z(k.to_float() * 360.0 / tab_count.to_float()));
}
fuse_all([tube, flange, bead]) - compound(slits)
