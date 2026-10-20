// Outboard throttle and shift control cable end clip: 1.5 mm spring plate 30 x 12 mm with a keyhole that snaps over a 6 mm cable end pin (6.2 mm entry, 5 mm locking neck 8 mm in), a 4 mm finger tab bent up at the back and 1 mm rounded corners
let pin_d = 6.0; // [4.0, 10.0] Cable pin diameter (mm)
let length = 30.0; // [22.0, 45.0] Clip length (mm)
let width = 12.0; // [10.0, 20.0] Clip width (mm)
const t = 1.5;
let w = max(width, pin_d + 6.0);
let plate = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, t]);
let plate = plate.fillet(1.0, plate.edges("|Z and >X"));
let tab = box_from_corners([0, -w / 2.0, 0], [t, w / 2.0, 4.0 + t]);
let body = plate + tab;
let xe = length - pin_d / 2.0 - 3.0;
let xl = xe - 8.0;
let neck = pin_d * 0.8;
let cuts = [
    cylinder([xe, 0, -1.0], "Z", pin_d / 2.0 + 0.1, t + 2.0),
    box_from_corners([xl, -neck / 2.0, -1.0], [xe, neck / 2.0, t + 1.0]),
    cylinder([xl, 0, -1.0], "Z", neck / 2.0, t + 2.0)
];
body - fuse_all(cuts)
