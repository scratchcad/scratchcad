// Kart water hose reducer from 32 mm to 25 mm hose: 70 mm long, 3 mm walls, each spigot 25 mm long with two 1 mm barb ridges, a 6 mm stop collar 4 mm proud in the middle and a 10 mm taper between bores
let big_d = 32.0; // [28.0, 40.0] Large hose bore (mm)
let small_d = 25.0; // [16.0, 28.0] Small hose bore (mm)
let spigot_len = 25.0; // [18.0, 40.0] Spigot length (mm)
const wall = 3.0;
let rb = big_d / 2.0;
let rs = small_d / 2.0;
let z1 = spigot_len;
let z2 = z1 + 6.0;
let z3 = z2 + spigot_len;
let pts = [[rs - wall, 0, 0], [rs - 0.5, 0, 0], [rs, 0, 1.0]];
for k in [0.4, 0.75] {
    let z = spigot_len * k;
    pts.push([rs, 0, z]);
    pts.push([rs + 1.0, 0, z + 3.0]);
    pts.push([rs, 0, z + 3.0]);
}
pts.push([rs, 0, z1]);
pts.push([rb + 4.0, 0, z1]);
pts.push([rb + 4.0, 0, z2]);
for k in [0.25, 0.6] {
    let z = z2 + spigot_len * k;
    pts.push([rb, 0, z]);
    pts.push([rb + 1.0, 0, z]);
    pts.push([rb, 0, z + 3.0]);
}
pts.push([rb, 0, z3 - 1.0]);
pts.push([rb - 0.5, 0, z3]);
pts.push([rb - wall, 0, z3]);
pts.push([rb - wall, 0, z2]);
pts.push([rs - wall, 0, z1 - 4.0]);
face(polygon(pts)).revolve("Z", 360.0)
