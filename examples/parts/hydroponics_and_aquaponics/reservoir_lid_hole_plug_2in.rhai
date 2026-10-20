// Reservoir lid blanking plug for an unused 2 inch net pot hole: 62 mm cap 3 mm thick over a 50.5 mm hollow stem 15 mm deep with a 2 mm wall and a 0.8 mm snap bead at its foot, and a 30 x 6 mm lift tab 8 mm tall on top
let hole_d = 50.5; // [40.0, 80.0] Lid hole diameter (mm)
let cap_d = 62.0; // [50.0, 100.0] Cap diameter (mm)
let stem_depth = 15.0; // [8.0, 25.0] Stem depth (mm)
let lid_t = 3.0; // [1.5, 6.0] Lid thickness (mm)
const t = 3.0;
const wall = 2.0;
let rs = hole_d / 2.0 - 0.25;
let rc = max(cap_d / 2.0, rs + 4.0);
let bead_z = -min(lid_t + 0.2, stem_depth - 1.5);
let pts = [[0, 0, 0], [rc, 0, 0], [rc, 0, t], [0, 0, t]];
let cap = face(polygon(pts)).revolve("Z", 360.0);
let stem = face(polygon([[rs - wall, 0, 0.5], [rs - wall, 0, -stem_depth], [rs - 0.6, 0, -stem_depth], [rs + 0.8, 0, bead_z - 1.2], [rs + 0.8, 0, bead_z],
    [rs, 0, bead_z + 0.2], [rs, 0, 0.5]])).revolve("Z", 360.0);
let tab = box_centered(min(30.0, rc), 6.0, 8.5).translate([0, 0, t + 4.0]);
let tab = tab.fillet(2.5, tab.edges("|Y and >Z"));
fuse_all([cap, stem, tab])
