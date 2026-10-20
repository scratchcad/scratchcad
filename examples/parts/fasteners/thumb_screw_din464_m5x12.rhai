// Knurled thumb screw DIN 464 M5 x 12: 16 mm knurled head 6.5 mm tall with 30 straight grooves, 10 mm collar 2 mm tall, plain 5 mm shank
let diameter = 5.0; // [3.0, 10.0] Nominal diameter (mm)
let length = 12.0; // [4.0, 40.0] Length under collar (mm)
let head_diameter = 16.0; // [8.0, 30.0] Knurled head diameter (mm)
let head_height = 6.5; // [3.0, 12.0] Head height (mm)
let collar_diameter = 10.0; // [5.0, 20.0] Collar diameter (mm)
const grooves = 30;
let r = diameter / 2.0;
let rk = max(head_diameter / 2.0, r + 2.0);
let rc = min(max(collar_diameter / 2.0, r + 1.0), rk - 0.5);
let shank = cylinder(r, length + 0.01).chamfer(min(0.5, r * 0.3), "<Z");
let collar = cylinder([0, 0, length], "Z", rc, 2.01);
let head = cylinder([0, 0, length + 2.0], "Z", rk, head_height).chamfer(min(0.5, head_height * 0.1));
let cuts = [];
for i in 0..grooves {
    let a = i.to_float() * 360.0 / grooves.to_float();
    cuts.push(polygon([[rk - 0.4, 0, length + 1.5], [rk + 0.5, -0.5, length + 1.5], [rk + 0.5, 0.5, length + 1.5]]).to_face().extrude(head_height + 1.0).rotate("Z", a));
}
fuse_all([shank, collar, head]) - compound(cuts)
