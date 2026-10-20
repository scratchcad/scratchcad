// Drag-chain link 10 x 15 mm inner section: two side plates 1.8 mm with pin and hole, top and bottom bars, 20 mm pitch
let inner_w = 15.0; // [8.0, 40.0] Inner width (mm)
let inner_h = 10.0; // [6.0, 30.0] Inner height (mm)
let pitch = 20.0; // [12.0, 40.0] Link pitch (mm)
let t = 1.8; // [1.2, 3.0] Wall thickness (mm)
let h = inner_h + 2.0 * t;
let plate = (box(pitch, t, h) + cylinder([pitch, 0, h / 2.0], "Y", h / 2.0, t) + cylinder([0, 0, h / 2.0], "Y", h / 2.0, t)) - cylinder([0, -1, h / 2.0], "Y", 1.6, t + 2.0);
let pin = cylinder([pitch, -1.5, h / 2.0], "Y", 1.5, 1.6);
let side = plate + pin;
let w = inner_w + 2.0 * t;
let bars = box(pitch * 0.6, w, t).translate([pitch * 0.2, 0, 0]) + box(pitch * 0.6, w, t).translate([pitch * 0.2, 0, h - t]);
fuse_all([side, side.mirror([0, w / 2.0, 0], "Y"), bars])
