// Button head socket screw ISO 7380-1 M5 x 10: 9.5 mm domed head 2.75 mm tall, 3 mm hex socket 1.3 mm deep, plain shank with tip chamfer
let diameter = 5.0; // [3.0, 16.0] Nominal diameter (mm)
let length = 10.0; // [4.0, 60.0] Length under head (mm)
let head_diameter = 9.5; // [5.7, 28.0] Head diameter (mm)
let head_height = 2.75; // [1.6, 8.8] Head height (mm)
let socket = 3.0; // [2.0, 10.0] Hex socket across flats (mm)
let r = diameter / 2.0;
let rk = max(head_diameter / 2.0, r + 1.0);
let hh = min(head_height, rk);
let edge = hh * 0.2;
let head = sketch("XZ").move_to(0.0, length).hline_to(rk).vline(edge).arc_to(rk * 0.6, length + hh * 0.85, 0.0, length + hh).close().to_face().revolve("Z", 360);
let screw = cylinder(r, length + 0.01).chamfer(min(0.5, r * 0.3), "<Z") + head;
let rc = min(socket, rk) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let ztop = length + hh;
let depth = hh * 0.55;
screw - fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, ztop - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, ztop - depth - rc * 0.577 + 0.01])])
