// Ward bed number sign holder: 110 mm U-channel that grips a 100 x 60 x 2 mm acrylic sign, 2.4 mm slot 8 mm deep, 3 mm walls, with two 15 mm screw tabs on the back carrying 4 mm holes
let sign_w = 100.0; // [70.0, 150.0] Sign width (mm)
let sign_t = 2.4; // [1.5, 4.0] Sign thickness slot (mm)
let grip = 8.0; // [5.0, 12.0] Grip depth (mm)
const t = 3.0;
let len = sign_w + 10.0;
let ch = box_from_corners([-len / 2.0, -sign_t / 2.0 - t, 0], [len / 2.0, sign_t / 2.0 + t, grip + t]);
ch = ch - box_from_corners([-sign_w / 2.0 - 0.5, -sign_t / 2.0, t], [sign_w / 2.0 + 0.5, sign_t / 2.0, grip + t + 1.0]);
let tabs = [];
for sx in [-1.0, 1.0] {
    tabs.push(box_from_corners([sx * len / 2.0 - 7.5, -sign_t / 2.0 - t - 15.0, 0], [sx * len / 2.0 + 7.5, -sign_t / 2.0 - t + 0.5, t]) - cylinder([sx * len / 2.0, -sign_t / 2.0 - t - 8.0, -1.0], "Z", 2.0, t + 2.0));
}
ch + fuse_all(tabs)
