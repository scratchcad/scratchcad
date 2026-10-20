// Steel-tip dart barrel, 90% tungsten, about 25 g: 50 mm long, 7.0 mm max diameter, tapered nose to 5.4 mm and tail to 6.0 mm, 14 ring grooves on a 22 mm grip zone, 2BA shaft socket 10 mm deep, 2.3 mm point hole 12 mm deep
let length = 50.0; // [35.0, 60.0] Barrel length (mm)
let max_d = 7.0; // [5.5, 9.0] Maximum diameter (mm)
let nose_d = 5.4; // [4.0, 7.0] Nose diameter (mm)
let tail_d = 6.0; // [4.5, 8.0] Tail diameter (mm)
let rings = 14; // [0, 20] Number of grip rings
const grip = 22.0;
const socket_d = 4.2;
const point_d = 2.3;
let rm = max_d / 2.0;
let rn = min(nose_d, max_d) / 2.0;
let rt = min(tail_d, max_d) / 2.0;
let g0 = length * 0.3;
let prof = [[0.0, 0.0], [rn - 0.3, 0.0], [rn, 0.3], [rm, g0], [rm, g0 + grip], [rt, length - 0.3], [rt - 0.3, length], [0.0, length]];
let barrel = polygon("XZ", prof).to_face().revolve("Z", 360);
let cuts = [];
let pitch = grip / (rings.to_float() + 1.0);
for i in 1..=rings {
    let z = g0 + i.to_float() * pitch;
    cuts.push(cone(rm - 0.35, rm + 0.5, 0.85).translate([0, 0, z - 0.85]) - cylinder([0, 0, z - 2.0], "Z", rm - 0.4, 4.0));
}
if rings > 0 { barrel = barrel - fuse_all(cuts); }
barrel - cylinder([0, 0, length - 10.0], "Z", socket_d / 2.0, 11.0) - cylinder([0, 0, -1.0], "Z", point_d / 2.0, 13.0)
