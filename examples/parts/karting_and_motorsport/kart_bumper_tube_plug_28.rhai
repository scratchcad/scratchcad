// Kart bumper tube end plug for 28 mm tube with 2 mm wall: 32 mm domed-edge cap 5 mm thick with a 1.5 mm chamfer, 20 mm spigot with three 0.6 mm barbed retaining rings sized for the 24 mm bore, hollowed with a 16 mm blind hole
let tube_od = 28.0; // [20.0, 35.0] Tube outside diameter (mm)
let tube_wall = 2.0; // [1.5, 3.0] Tube wall thickness (mm)
let spigot_len = 20.0; // [12.0, 30.0] Spigot length (mm)
const cap_t = 5.0;
let rc = tube_od / 2.0 + 2.0;
let rb = tube_od / 2.0 - tube_wall - 0.1;
let rh = rb - 3.0;
let pts = [[rh, 0, 0], [rh, 0, -spigot_len + 2.0], [rb - 1.0, 0, -spigot_len + 2.0], [rb - 1.0, 0, -spigot_len], [rb - 0.6, 0, -spigot_len]];
let step = (spigot_len - 3.0) / 3.0;
for i in 0..3 {
    let z = -spigot_len + 1.0 + i.to_float() * step;
    pts.push([rb + 0.6, 0, z + step - 0.5]);
    pts.push([rb - 0.4, 0, z + step]);
}
pts.push([rb - 0.4, 0, 0]);
pts.push([rc, 0, 0]);
pts.push([rc, 0, cap_t - 1.5]);
pts.push([rc - 1.5, 0, cap_t]);
pts.push([0, 0, cap_t]);
pts.push([0, 0, 1.0]);
pts.push([rh, 0, 1.0]);
face(polygon(pts)).revolve("Z", 360.0)
