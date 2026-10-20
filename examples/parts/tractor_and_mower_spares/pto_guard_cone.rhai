// PTO shaft guard cone: 130 mm skirt, 70 mm neck, 110 mm long, 2.5 mm wall with 3 locking lugs at the neck
let skirt = 130.0; // [100.0, 180.0] Skirt diameter (mm)
let neck = 70.0; // [50.0, 100.0] Neck diameter (mm)
let length = 110.0; // [80.0, 160.0] Length (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let c = cone(skirt / 2.0, neck / 2.0, length) - cone(skirt / 2.0 - wall, neck / 2.0 - wall, length + 0.02).translate([0, 0, -0.01]);
let lugs = [];
for k in 0..3 { lugs.push(box_from_corners([neck / 2.0 - wall - 4.0, -5.0, length - 10.0], [neck / 2.0 + 2.0, 5.0, length - 4.0]).rotate_z(k.to_float() * 120.0)); }
c + fuse_all(lugs)
