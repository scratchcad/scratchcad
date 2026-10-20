// Washroom glass or solid shelf concealed bracket: 50 mm round wall rose 8 mm thick with two 4.5 mm countersunk screw holes 30 mm apart, a 16 mm round support pin 40 mm long, and a 4.8 mm deep, 8.5 mm wide slot along the pin top for a shelf retaining strip
let pin_d = 16.0; // [10.0, 25.0] Support pin diameter (mm)
let pin_len = 40.0; // [20.0, 80.0] Support pin length (mm)
let rose_d = 50.0; // [36.0, 70.0] Rose diameter (mm)
let slot_w = 8.5; // [0.0, 12.0] Retaining slot width (mm)
const rose_t = 8.0;
let rr = rose_d / 2.0;
let pr = min(pin_d / 2.0, rr - 9.0);
let rose = cylinder([0, 0, 0], "Y", rr, rose_t);
let rose = rose.chamfer(1.5, rose.edges(">Y"));
let pin = cylinder([0, rose_t - 0.5, 0], "Y", pr, pin_len + 0.5);
let pin = pin.chamfer(1.0, pin.edges(">Y"));
let body = rose + pin;
let hs = min(15.0, rr - 5.0);
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([0, -1.0, s * hs], "Y", 2.25, rose_t + 2.0));
    cuts.push(cone(2.25, 4.5, 2.25).rotate_x(-90.0).translate([0, rose_t - 2.24, s * hs]));
}
let sw = min(slot_w, pr * 1.2);
if sw > 0.5 {
    cuts.push(box_from_corners([-sw / 2.0, rose_t + 3.0, pr - min(6.0, pr * 0.6)], [sw / 2.0, rose_t + pin_len + 1.0, pr + 1.0]));
}
(body - fuse_all(cuts)).mirror("XZ")
