// Hexagon socket set screw ISO 4029 M4 x 6, cup point: 2 mm hex socket 2 mm deep, 2 mm cup diameter with a 118 deg cup, 0.7 mm pitch thread rings
let diameter = 4.0; // [2.0, 16.0] Nominal diameter (mm)
let length = 6.0; // [3.0, 40.0] Length (mm)
let pitch = 0.7; // [0.4, 2.0] Thread pitch (mm)
let socket = 2.0; // [0.9, 8.0] Hex socket across flats (mm)
let cup_diameter = 2.0; // [0.8, 10.0] Cup diameter (mm)
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let rcup = min(cup_diameter / 2.0, rm - 0.2);
let p = [[0.0, 0.0, 0.0], [rcup + 0.3, 0.0, 0.0], [rm, 0.0, rm - rcup - 0.3]];
let z = rm - rcup - 0.3;
while z + pitch < length - 0.5 {
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([rm, 0.0, length]);
p.push([0.0, 0.0, length]);
let screw = polygon(p).to_face().revolve("Z", 360);
let cup = cone(rcup, 0.0, rcup * (31.0 * PI() / 180.0).tan()).translate([0, 0, -0.01]);
let rc = min(socket, diameter * 0.7) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = min(2.0, length * 0.5);
screw - fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, length - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, length - depth - rc * 0.577 + 0.01])]) - cup
