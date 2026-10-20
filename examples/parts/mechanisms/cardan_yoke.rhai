// Universal joint yoke for a 10 mm shaft: 22 mm OD hub, ears 16 mm apart for a 16 mm cross with 5 mm pins
let shaft = 10.0; // [6.0, 20.0] Shaft bore (mm)
let hub_d = 22.0; // [14.0, 40.0] Hub diameter (mm)
let gap = 16.0; // [10.0, 30.0] Gap between ears (mm)
let pin = 5.0; // [3.0, 8.0] Cross pin (mm)
let ear_t = 4.0; // [3.0, 8.0] Ear thickness (mm)
let hub = cylinder(hub_d / 2.0, 20.0);
let pin_z = 20.0 + gap / 2.0;
let ear_r = pin / 2.0 + 3.5;
let ears = [];
for s in [-1.0, 1.0] {
    let x0 = if s < 0.0 { -gap / 2.0 - ear_t } else { gap / 2.0 };
    ears.push(box_from_corners([x0, -ear_r, 19.99], [x0 + ear_t, ear_r, pin_z]) + cylinder([x0, 0, pin_z], "X", ear_r, ear_t));
}
let y = (fuse_all(ears) & cylinder([0, 0, 19.0], "Z", hub_d / 2.0, gap + 20.0)) + hub;
y - cylinder([0, 0, -1], "Z", shaft / 2.0, 19.0) - cylinder([-hub_d, 0, pin_z], "X", pin / 2.0, hub_d * 2.0) - cylinder([0, -hub_d, 8.0], "Y", 1.6, hub_d * 2.0)
