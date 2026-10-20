// Blind rivet nut M6, flat head, open end, steel: 9 mm ribbed body 15.5 mm long, 13 mm head 1.5 mm thick, 7.1 mm unthreaded collapse zone 6 mm deep, 5 mm tap bore
let thread_diameter = 6.0; // [3.0, 12.0] Thread size (mm)
let body_diameter = 9.0; // [5.0, 16.0] Body diameter (mm)
let length = 15.5; // [8.0, 30.0] Body length (mm)
let head_diameter = 13.0; // [7.0, 24.0] Head diameter (mm)
let head_thickness = 1.5; // [0.8, 3.0] Head thickness (mm)
const ribs = 8;
let rb = max(body_diameter / 2.0, thread_diameter / 2.0 + 1.0);
let rh = max(head_diameter / 2.0, rb + 1.5);
let body = cylinder([0, 0, -length], "Z", rb, length + 0.01).chamfer(0.4, "<Z");
let head = cylinder(rh, head_thickness).fillet(min(0.5, head_thickness * 0.4), ">Z");
let nut = body + head;
let flutes = [];
for i in 0..ribs {
    let a = i.to_float() * 360.0 / ribs.to_float();
    flutes.push(cylinder([rb + 0.15, 0, -length * 0.9], "Z", 0.45, length * 0.9 - 1.0).rotate("Z", a));
}
nut = nut - compound(flutes);
let collapse = rb - 1.0;
nut - fuse_all([cylinder([0, 0, -length * 0.4], "Z", collapse, length * 0.4 + head_thickness + 1.0), cylinder([0, 0, -length - 1.0], "Z", thread_diameter * 0.42, length + 2.0)])
