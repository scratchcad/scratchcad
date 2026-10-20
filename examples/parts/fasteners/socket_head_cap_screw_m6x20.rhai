// Socket head cap screw ISO 4762 M6 x 20: 10 mm head 6 mm tall, 5 mm hex socket 3 mm deep, plain 6 mm shank with a 45 deg 1 mm tip chamfer
let diameter = 6.0; // [2.0, 24.0] Nominal diameter (mm)
let length = 20.0; // [4.0, 120.0] Length under head (mm)
let head_diameter = 10.0; // [3.8, 36.0] Head diameter (mm)
let head_height = 6.0; // [2.0, 24.0] Head height (mm)
let socket = 5.0; // [1.5, 19.0] Hex socket across flats (mm)
let socket_depth = 3.0; // [1.0, 12.0] Socket depth (mm)
let r = diameter / 2.0;
let rk = max(head_diameter / 2.0, r + 0.8);
let head = cylinder([0, 0, length - 0.01], "Z", rk, head_height + 0.01).fillet(min(0.6, head_height * 0.1), ">Z");
let shank = cylinder(r, length).chamfer(min(1.0, r * 0.3), "<Z");
let screw = head + shank;
let s = min(socket, rk * 1.4);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = min(socket_depth, head_height - 0.5);
let ztop = length + head_height;
let recess = fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, ztop - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, ztop - depth - rc * 0.577 + 0.01])]);
screw - recess
