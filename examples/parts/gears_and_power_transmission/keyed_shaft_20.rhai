// 20 mm keyed shaft, 120 mm long, DIN 6885 6 x 6 keyway 40 mm long and a 1 x 45 deg chamfer each end
let diameter = 20.0; // [8.0, 60.0] Diameter (mm)
let length = 120.0; // [40.0, 500.0] Length (mm)
let key_w = 6.0; // [2.0, 18.0] Keyway width (mm)
let key_depth = 3.5; // [1.2, 7.0] Keyway depth (mm)
let key_l = 40.0; // [10.0, 100.0] Keyway length (mm)
let shaft = cylinder([0, 0, 0], "X", diameter / 2.0, length).chamfer(1.0);
let slot = box_from_corners([10.0 + key_w / 2.0, -key_w / 2.0, diameter / 2.0 - key_depth], [10.0 + key_l - key_w / 2.0, key_w / 2.0, diameter])
    + cylinder([10.0 + key_w / 2.0, 0, diameter / 2.0 - key_depth], "Z", key_w / 2.0, key_depth + 5.0)
    + cylinder([10.0 + key_l - key_w / 2.0, 0, diameter / 2.0 - key_depth], "Z", key_w / 2.0, key_depth + 5.0);
shaft - slot
