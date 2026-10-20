// Hexagon socket countersunk head screw ISO 10642 M4 x 12: 90 deg head 8 mm across, 2.2 mm tall, 2.5 mm hex socket, thread shown as 0.7 mm pitch rings
let diameter = 4.0; // [2.0, 12.0] Nominal diameter (mm)
let length = 12.0; // [5.0, 60.0] Overall length including head (mm)
let pitch = 0.7; // [0.4, 1.75] Thread pitch (mm)
let head_diameter = 8.0; // [4.0, 24.0] Head diameter (mm)
let socket = 2.5; // [1.3, 8.0] Hex socket across flats (mm)
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let rk = max(head_diameter / 2.0, r + 0.8);
let k = rk - r;
let zt = length - k - 0.15;
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
let z = 0.0;
while z + pitch < zt - 0.5 {
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([r, 0.0, z + (r - rm)]);
p.push([r, 0.0, zt]);
p.push([rk, 0.0, length - 0.15]);
p.push([rk, 0.0, length]);
p.push([0.0, 0.0, length]);
let screw = polygon(p).to_face().revolve("Z", 360);
let rc = min(socket, rk) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = k * 0.66;
screw - fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, length - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, length - depth - rc * 0.577 + 0.01])])
