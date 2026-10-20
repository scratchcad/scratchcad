// Arduino Nano board model: 43.2 x 18 x 1.6 mm PCB, mini-USB connector, ATmega328 TQFP, two 15-pin headers
let length = 43.2; // [40.0, 50.0] PCB length (mm)
let width = 18.0; // [15.0, 22.0] PCB width (mm)
let pcb = box(length, width, 1.6);
for p in [[1.27, 1.27], [length - 1.27, 1.27], [1.27, width - 1.27], [length - 1.27, width - 1.27]] { pcb -= cylinder([p[0], p[1], -1], "Z", 0.9, 4.0); }
let usb = box(9.0, 7.5, 4.0).translate([-1.0, (width - 7.5) / 2.0, 1.6]);
let mcu = box_centered(7.0, 7.0, 1.2).translate([length * 0.6, width / 2.0, 1.6 + 0.6]).rotate([length * 0.6, width / 2.0, 0], "Z", 45);
let headers = [];
for row in [1.27 + 0.0, width - 1.27] { headers.push(box_from_corners([3.0, row - 1.27, -2.5], [3.0 + 15.0 * 2.54, row + 1.27, 0.0])); }
let pins = [];
for row in [1.27, width - 1.27] { for i in 0..15 { pins.push(box_centered(0.64, 0.64, 8.0).translate([4.27 + i.to_float() * 2.54, row, -3.0])); } }
fuse_all([pcb, usb, mcu] + headers + pins)
