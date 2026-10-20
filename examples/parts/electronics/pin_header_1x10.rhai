// 1 x 10 male pin header: 2.54 mm pitch, 2.5 mm plastic carrier, 0.64 mm square pins 6 mm up and 3 mm down
let pins = 10; // [1, 40] Pins
let pitch = 2.54; // [1.27, 2.54] Pitch (mm)
let carrier = box_centered(pins.to_float() * pitch, 2.5, 2.5).translate([0, 0, 1.25]).chamfer(0.3, "|Z");
let pin_list = [];
for i in 0..pins { pin_list.push(box_centered(0.64, 0.64, 11.5).translate([-(pins - 1).to_float() * pitch / 2.0 + i.to_float() * pitch, 0, 2.75]).chamfer(0.15, ">Z or <Z")); }
fuse_all([carrier] + pin_list)
