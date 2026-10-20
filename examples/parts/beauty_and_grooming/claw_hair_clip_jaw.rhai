// Claw hair clip half: 85 mm wide comb jaw, 9 interlocking teeth 30 mm long, 4 mm thick, 6 mm hinge knuckles
let width = 85.0; // [60.0, 110.0] Clip width (mm)
let teeth = 9; // [6, 14] Number of teeth
let tooth_l = 30.0; // [20.0, 40.0] Tooth length (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let spine = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, 8.0, t]);
let teeth_ = [];
let pitch = width / teeth.to_float();
for i in 0..teeth { let x = -width / 2.0 + (i.to_float() + 0.5) * pitch; teeth_.push(polygon([[x - pitch * 0.25, 0.01], [x + pitch * 0.25, 0.01], [x + pitch * 0.12, -tooth_l], [x - pitch * 0.12, -tooth_l]]).to_face().extrude([0, 0, t])); }
let knuckles = [];
for x in [-width * 0.3, 0.0, width * 0.3] { knuckles.push(cylinder([x - 5.0, 8.0, t / 2.0 + 1.0], "X", 3.0, 10.0) - cylinder([x - 6.0, 8.0, t / 2.0 + 1.0], "X", 1.2, 12.0)); }
spine + fuse_all(teeth_) + fuse_all(knuckles)
