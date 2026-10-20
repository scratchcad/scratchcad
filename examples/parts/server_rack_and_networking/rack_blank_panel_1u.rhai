// 19 inch rack blanking panel 1U: 482.6 x 44.45 mm face 2 mm thick, 465 mm stiffening return 10 mm deep top and bottom, four 7 x 10 mm slotted mounting holes on 465.1 mm centres
let units = 1; // [1, 4] Height in rack units
let return_d = 10.0; // [6.0, 20.0] Stiffening return depth (mm)
const t = 2.0;
let h = 44.45 * units.to_float() - 0.8;
let face_ = box_from_corners([-241.3, 0, 0], [241.3, t, h]);
let returns = box_from_corners([-225.0, t - 0.01, 0], [225.0, t + return_d, t]) + box_from_corners([-225.0, t - 0.01, h - t], [225.0, t + return_d, h]);
let slots = [];
for sx in [-1.0, 1.0] { for z in [6.35, h - 6.35] {
    slots.push(box_centered(3.0, t + 2.0, 7.0).translate([sx * 232.55, t / 2.0, z]) + cylinder([sx * 232.55 - 1.5, -1.0, z], "Y", 3.5, t + 2.0) + cylinder([sx * 232.55 + 1.5, -1.0, z], "Y", 3.5, t + 2.0));
} }
face_ + returns - fuse_all(slots)
