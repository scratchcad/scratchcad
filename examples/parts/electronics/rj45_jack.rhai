// RJ45 jack: 16 x 21 x 13.5 mm housing with an 11.7 x 8 mm plug opening and latch slot, 8 contacts, two LEDs
let width = 16.0; // [15.0, 17.0] Width (mm)
let depth = 21.0; // [18.0, 22.0] Depth (mm)
let height = 13.5; // [11.0, 14.0] Height (mm)
let housing = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
housing = housing - box_centered(11.7, depth * 0.8, 8.0).translate([0, -depth * 0.1 - 1.0, 4.5]);
housing = housing - box_centered(6.0, depth * 0.5, 3.0).translate([0, -depth * 0.25 - 1.0, 9.5]);
let leds = box_centered(3.0, 1.0, 2.0).translate([-width / 2.0 + 2.5, -depth / 2.0 + 0.4, height - 2.0]) + box_centered(3.0, 1.0, 2.0).translate([width / 2.0 - 2.5, -depth / 2.0 + 0.4, height - 2.0]);
let pins = [];
for i in 0..8 { pins.push(box_centered(0.4, 0.4, 3.5).translate([-4.445 + i.to_float() * 1.27, depth * 0.2 + (i % 2).to_float() * 2.54, -1.7])); }
fuse_all([housing, leds] + pins)
