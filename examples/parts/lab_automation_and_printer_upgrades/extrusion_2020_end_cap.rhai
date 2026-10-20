// Push-in end cap for 2020 aluminium extrusion: 20 x 20 mm cap 3 mm thick with 1.5 mm rounded corners, 4 slot keys 5.8 mm wide 6 mm long that press into the 6.2 mm slots, 4.0 mm centre pin 6 mm long
let size = 20.0; // [20.0, 40.0] Profile size (mm)
let cap_t = 3.0; // [2.0, 5.0] Cap thickness (mm)
let key_w = 5.8; // [5.0, 8.0] Slot key width (mm)
let key_l = 6.0; // [3.0, 10.0] Key length (mm)
let pin_d = 4.0; // [0.0, 5.0] Centre pin diameter, 0 for none (mm)
let h = size / 2.0;
let cap = box_centered(size, size, cap_t).translate([0, 0, cap_t / 2.0]);
cap = cap.fillet(1.5, "|Z").chamfer(0.6, ">Z");
let keys = [];
for k in 0..4 {
    keys.push(box_from_corners([h - 4.0, -key_w / 2.0, -key_l], [h - 0.3, key_w / 2.0, 0.5]).rotate_z(k.to_float() * 90.0));
}
cap = cap + fuse_all(keys);
if pin_d > 0.5 {
    cap = cap + cylinder([0, 0, -key_l], "Z", pin_d / 2.0, key_l + 0.5);
}
cap
