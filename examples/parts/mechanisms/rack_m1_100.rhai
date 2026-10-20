// Spur rack, module 1, 20 degree: 100 mm long, 10 x 10 mm bar, pitch line 9 mm above the base
let module_ = 1.0; // [0.5, 3.0] Module (mm)
let length = 100.0; // [30.0, 300.0] Length (mm)
let face = 10.0; // [5.0, 20.0] Face width (mm)
let height = 10.0; // [6.0, 20.0] Bar height incl. teeth (mm)
let p = PI() * module_;
let add = module_;
let ded = 1.25 * module_;
let pitch_z = height - add;
let tan20 = (20.0 * PI() / 180.0).tan();
let bar = box_from_corners([0, 0, 0], [length, face, pitch_z - ded]);
let teeth = [];
let n = (length / p).floor().to_int();
for i in 0..n {
    let x = (i.to_float() + 0.5) * p;
    let top_hw = p / 4.0 - add * tan20;
    let root_hw = p / 4.0 + ded * tan20;
    teeth.push(polygon([[x - root_hw, pitch_z - ded - 0.01], [x + root_hw, pitch_z - ded - 0.01], [x + top_hw, height], [x - top_hw, height]]).to_face().extrude([0, 0, face]).rotate_x(90.0).translate([0, face, 0]));
}
bar + fuse_all(teeth)
