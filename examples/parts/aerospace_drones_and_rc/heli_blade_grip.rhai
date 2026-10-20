// RC helicopter main blade grip: 14 mm bearing housing with 10 mm bore, 4 mm blade slot between 2 mm cheeks with 3 mm bolt, pitch arm
let slot = 4.0; // [3.0, 6.0] Blade root thickness (mm)
let housing = cylinder([0, 0, 0], "X", 7.0, 22.0);
let cheeks = [];
for s in [-1.0, 1.0] { cheeks.push(box_from_corners([18.0, -7.0, s * slot / 2.0], [42.0, 7.0, s * (slot / 2.0 + 2.0)])); }
let arm = box_from_corners([4.0, 6.0, -1.5], [10.0, 18.0, 1.5]);
let grip = fuse_all([housing, arm] + cheeks);
grip - cylinder([-1, 0, 0], "X", 5.0, 18.0) - cylinder([35.0, 0, -5.0], "Z", 1.5, 10.0) - cylinder([7.0, 16.0, -3.0], "Z", 1.0, 6.0)
