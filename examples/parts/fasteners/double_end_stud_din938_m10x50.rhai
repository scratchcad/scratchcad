// Double-end stud DIN 938 M10 x 50: 10 mm metal end (1d), 26 mm nut-end thread, 1.5 mm pitch rings, plain 10 mm shank between, chamfered ends
let diameter = 10.0; // [5.0, 24.0] Nominal diameter (mm)
let length = 50.0; // [25.0, 150.0] Length above the metal end (mm)
let metal_end = 10.0; // [5.0, 30.0] Metal end thread length (mm)
let nut_thread = 26.0; // [10.0, 60.0] Nut end thread length (mm)
let pitch = 1.5; // [0.8, 3.0] Thread pitch (mm)
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let nt = min(nut_thread, length - 4.0);
let total = metal_end + length;
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
let z = 0.0;
while z + pitch < metal_end {
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([r, 0.0, z + (r - rm)]);
let zs = total - nt;
p.push([r, 0.0, zs]);
p.push([rm, 0.0, zs + (r - rm)]);
z = zs + (r - rm);
while z + pitch < total {
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([rm, 0.0, total]);
p.push([0.0, 0.0, total]);
polygon(p).to_face().revolve("Z", 360)
