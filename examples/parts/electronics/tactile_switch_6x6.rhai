// 6 x 6 mm tactile switch: 3.5 mm body, 3.5 mm round actuator 1.5 mm tall, metal frame, 4 legs at 6.5 x 4.5 mm
let size = 6.0; // [6.0, 12.0] Body size (mm)
let body_h = 3.5; // [3.0, 5.0] Body height (mm)
let button_d = 3.5; // [3.0, 7.0] Button diameter (mm)
let button_h = 1.5; // [0.5, 10.0] Button height above the body (mm)
let body = box_centered(size, size, body_h).translate([0, 0, body_h / 2.0]);
let frame = box_centered(size + 0.2, size + 0.2, 0.3).translate([0, 0, body_h - 0.15]) - cylinder([0, 0, body_h - 1], "Z", button_d / 2.0 + 0.3, 2.0);
let button = cylinder([0, 0, body_h - 0.01], "Z", button_d / 2.0, button_h + 0.01);
let legs = [];
for sx in [-1, 1] { for sy in [-1, 1] { legs.push(box_centered(0.7, 0.3, 3.5).translate([sx * 3.25, sy * 2.25, -1.0])); } }
fuse_all([body, frame, button] + legs)
