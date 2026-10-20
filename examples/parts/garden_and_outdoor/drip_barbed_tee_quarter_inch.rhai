// 1/4 in drip irrigation barbed tee: three 4.6 mm double barbs for 4 mm ID micro tubing, 2.6 mm bore, 22 mm across
let barb_diameter = 4.6; // [3.5, 7.0] Barb diameter (mm)
let arm_length = 11.0; // [7.0, 18.0] Arm length from the centre (mm)
let bore = 2.6; // [1.5, 4.0] Bore diameter (mm)
let rb = barb_diameter / 2.0;
let rs = rb - 0.6;
let rbore = min(bore / 2.0, rs - 0.5);
let l = arm_length;
let arm = polygon([[0, 0, 0], [rs + 0.6, 0, 0], [rs + 0.6, 0, 3.5], [rs, 0, 3.5], [rb, 0, l - 4.0], [rs, 0, l - 4.0], [rb, 0, l - 0.8], [rs - 0.3, 0, l], [0, 0, l]])
    .to_face().revolve("Z", 360);
let hub = sphere(rs + 1.2);
let tee = fuse_all([hub, arm.rotate_y(90.0), arm.rotate_y(-90.0), arm.rotate_x(-90.0)]);
tee - fuse_all([cylinder([-l - 1.0, 0, 0], "X", rbore, 2.0 * l + 2.0), cylinder([0, 0, 0], "Y", rbore, l + 1.0)])
