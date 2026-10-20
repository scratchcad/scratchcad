// JST XH 4-pin header: 2.5 mm pitch, 12.4 x 5.75 x 7 mm shroud with polarising slots, square 0.64 mm pins
let pins = 4; // [2, 12] Pins
let pitch = 2.5; // [2.0, 2.54] Pitch (mm)
let depth = 5.75; // [5.0, 7.0] Depth (mm)
let height = 7.0; // [6.0, 9.0] Height (mm)
let length = (pins - 1).to_float() * pitch + 4.9;
let shroud = box_centered(length, depth, height).translate([0, 0, height / 2.0]) - box_centered(length - 1.6, depth - 1.6, height).translate([0, 0, height / 2.0 + 1.0]);
shroud = shroud - box_centered(1.5, 2.0, height).translate([-length / 2.0 + 2.0, depth / 2.0, height / 2.0 + 2.0]) - box_centered(1.5, 2.0, height).translate([length / 2.0 - 2.0, depth / 2.0, height / 2.0 + 2.0]);
let pin_list = [];
for i in 0..pins { pin_list.push(box_centered(0.64, 0.64, 9.5).translate([-(pins - 1).to_float() * pitch / 2.0 + i.to_float() * pitch, 0, 3.0])); }
fuse_all([shroud] + pin_list)
