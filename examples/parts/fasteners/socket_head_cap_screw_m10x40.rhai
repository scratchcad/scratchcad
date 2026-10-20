// Socket head cap screw ISO 4762 M10 x 40: 16 mm head 10 mm tall, 8 mm hex socket 5 mm deep, 1.5 mm pitch thread shown as rings over the 32 mm thread length, 8.16 mm minor diameter
let diameter = 10.0; // [4.0, 24.0] Nominal diameter (mm)
let length = 40.0; // [10.0, 150.0] Length under head (mm)
let thread_length = 32.0; // [5.0, 80.0] Thread length (mm)
let pitch = 1.5; // [0.5, 3.0] Thread pitch (mm)
let head_diameter = 16.0; // [7.0, 36.0] Head diameter (mm)
let head_height = 10.0; // [4.0, 24.0] Head height (mm)
let socket = 8.0; // [2.5, 19.0] Hex socket across flats (mm)
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let rk = max(head_diameter / 2.0, r + 1.0);
let tl = min(thread_length, length);
let rings = (tl / pitch).floor().to_int();
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
for i in 0..rings {
    let z = i.to_float() * pitch;
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
}
let zt = rings.to_float() * pitch;
p.push([r, 0.0, zt + (r - rm)]);
p.push([r, 0.0, length + 0.01]);
p.push([0.0, 0.0, length + 0.01]);
let shank = polygon(p).to_face().revolve("Z", 360);
let head = cylinder([0, 0, length], "Z", rk, head_height).fillet(min(0.8, head_height * 0.1), ">Z");
let screw = shank + head;
let rc = min(socket, rk * 1.4) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = head_height * 0.5;
let ztop = length + head_height;
let recess = fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, ztop - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, ztop - depth - rc * 0.577 + 0.01])]);
screw - recess
