// PCIe full-height slot cover: 120 x 18.4 mm blade, 0.9 mm, 90 degree tab 11.5 mm with screw notch, lower tongue
let length = 120.0; // [100.0, 121.0] Blade length (mm)
let width = 18.4; // [15.0, 21.6] Blade width (mm)
let t = 0.9; // [0.8, 1.2] Thickness (mm)
let blade = box_from_corners([0, 0, 0], [width, t, length]);
let tab = box_from_corners([0, 0, length - t], [width, 11.5, length]) - cylinder([width / 2.0 + 2.0, 7.0, length - 2.0], "Z", 2.1, 4.0) - box_from_corners([width / 2.0 + 2.0, 4.9, length - 2.0], [width + 1.0, 9.1, length + 1.0]);
let tongue = box_from_corners([width / 2.0 - 2.5, 0, -10.0], [width / 2.0 + 2.5, t, 0.01]);
let vents = [];
for k in 0..6 { vents.push(box_from_corners([4.0, -1, 15.0 + k.to_float() * 14.0], [width - 4.0, t + 1.0, 25.0 + k.to_float() * 14.0])); }
blade + tab + tongue - compound(vents)
