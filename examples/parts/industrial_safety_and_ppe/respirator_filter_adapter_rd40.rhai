// Respirator filter adapter: EN 148-1 Rd40 x 1/7 in male thread (40 mm major, 3.63 mm pitch, 12 mm long) on a 48 mm grip flange, 30 mm air bore, 22 mm hose spigot 20 mm long
let major = 40.0; // [38.0, 42.0] Thread major diameter (mm)
let pitch = 3.63; // [3.0, 4.2] Thread pitch (mm)
let thread_length = 12.0; // [8.0, 18.0] Thread length (mm)
let flange = 48.0; // [44.0, 56.0] Flange diameter (mm)
let bore = 30.0; // [24.0, 33.0] Air bore (mm)
let spigot = 22.0; // [18.0, 28.0] Hose spigot diameter (mm)
let depth = pitch * 0.5;
let turns = (thread_length / pitch).floor().to_int();
// thread modelled as revolved straight-flank ridges (not helical)
let pts = [[bore / 2.0, 0.0], [major / 2.0 - depth, 0.0]];
for i in 0..turns {
    let z = i.to_float() * pitch;
    pts.push([major / 2.0 - depth, z + pitch * 0.1]);
    pts.push([major / 2.0, z + pitch * 0.4]);
    pts.push([major / 2.0, z + pitch * 0.6]);
    pts.push([major / 2.0 - depth, z + pitch * 0.9]);
}
let top = turns.to_float() * pitch;
pts.push([major / 2.0 - depth, top + 1.0]);
pts.push([flange / 2.0, top + 1.0]);
pts.push([flange / 2.0, top + 9.0]);
pts.push([spigot / 2.0 + 2.0, top + 12.0]);
pts.push([spigot / 2.0, top + 13.0]);
pts.push([spigot / 2.0, top + 30.0]);
pts.push([spigot / 2.0 - 2.5, top + 33.0]);
pts.push([spigot / 2.0 - 2.5, top + 13.0]);
pts.push([bore / 2.0, top + 9.0]);
let body = polygon("XZ", pts).to_face().revolve([0, 0, 0], "Z", 360);
// grip notches around the flange
let notches = [];
for k in 0..12 { notches.push(cylinder([flange / 2.0 + 1.0, 0, top], "Z", 2.5, 11.0).rotate_z(k.to_float() * 30.0)); }
body - compound(notches)
