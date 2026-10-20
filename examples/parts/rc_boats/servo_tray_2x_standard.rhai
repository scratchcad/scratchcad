// RC servo tray for two standard servos: 100 x 60 x 3 mm plate, two 41 x 20.5 mm cut-outs on 30 mm centres with 2.4 mm mounting holes 48 mm apart, and 4 corner holes
let width = 100.0; // [90.0, 140.0] Tray width (mm)
let servo_w = 20.5; // [12.0, 22.0] Servo body width (mm)
const t = 3.0;
const servo_l = 41.0;
let p = box_centered(width, 60.0, t).translate([0, 0, t / 2.0]);
let cuts = [];
for y in [-15.0, 15.0] {
    cuts.push(box_centered(servo_l, servo_w, t + 2.0).translate([0, y, t / 2.0]));
    cuts.push(cylinder([-24.0, y, -1.0], "Z", 1.2, t + 2.0));
    cuts.push(cylinder([24.0, y, -1.0], "Z", 1.2, t + 2.0));
}
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { cuts.push(cylinder([sx * (width / 2.0 - 5.0), sy * 25.0, -1.0], "Z", 1.6, t + 2.0)); } }
p - fuse_all(cuts)
