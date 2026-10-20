// Centre finder for round stock up to 100 mm: 90 degree V fence with 70 mm arms 10 mm wide and 8 mm thick, 3 mm blade 20 mm wide on the bisector
let arm_l = 70.0; // [40.0, 120.0] Fence arm length (mm)
let arm_w = 10.0; // [6.0, 16.0] Fence arm width (mm)
let fence_t = 8.0; // [5.0, 12.0] Fence thickness (mm)
let blade_l = 100.0; // [60.0, 160.0] Blade length (mm)
let blade_t = 3.0; // [2.0, 5.0] Blade thickness (mm)
let arm1 = box_from_corners([0, -arm_w, 0], [arm_l, 0, fence_t]).rotate_z(45.0);
let arm2 = box_from_corners([0, 0, 0], [arm_l, arm_w, fence_t]).rotate_z(135.0);
let corner = box_from_corners([-arm_w, -arm_w, 0], [0.01, 0.01, fence_t]).rotate_z(45.0);
let blade = box_from_corners([0, -arm_w, 0], [20.0, blade_l, blade_t]);
let p = fuse_all([arm1, arm2, corner, blade]);
p - cylinder([10.0, blade_l - 8.0, -1], "Z", 3.0, blade_t + 2.0)
