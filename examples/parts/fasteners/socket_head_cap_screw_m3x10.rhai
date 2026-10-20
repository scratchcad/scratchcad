// Socket head cap screw ISO 4762 M3 x 10: 5.5 mm head 3 mm tall, 2.5 mm hex socket 1.3 mm deep, plain shank, 0.3 mm tip chamfer, knurl-free head
let diameter = 3.0; // [1.6, 12.0] Nominal diameter (mm)
let length = 10.0; // [3.0, 60.0] Length under head (mm)
let head_diameter = 5.5; // [3.0, 18.0] Head diameter (mm)
let head_height = 3.0; // [1.6, 12.0] Head height (mm)
let socket = 2.5; // [0.9, 10.0] Hex socket across flats (mm)
let socket_depth = 1.3; // [0.7, 6.0] Socket depth (mm)
let r = diameter / 2.0;
let rk = max(head_diameter / 2.0, r + 0.5);
let screw = cylinder(r, length + 0.01).chamfer(min(0.3, r * 0.3), "<Z") + cylinder([0, 0, length], "Z", rk, head_height).chamfer(min(0.2, head_height * 0.1), ">Z");
let rc = min(socket, rk * 1.4) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = min(socket_depth, head_height - 0.4);
let ztop = length + head_height;
let recess = polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, ztop - depth]);
let point = cone(0.0, rc, rc * 0.577).translate([0, 0, ztop - depth - rc * 0.577 + 0.01]);
screw - fuse_all([recess, point])
