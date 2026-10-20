// Desk USB-C cable holder: 60 x 20 x 15 mm block with 4 slots 4.5 mm wide for 4 mm cables, 8 mm plug stops
let n = 4; // [2, 8] Slot count
let cable = 4.5; // [3.0, 7.0] Slot width (mm)
let height = 15.0; // [10.0, 25.0] Height (mm)
let pitch = 14.0; // [10.0, 20.0] Pitch (mm)
let length = n.to_float() * pitch + 4.0;
let block = box_from_corners([0, 0, 0], [length, 20.0, height]);
let b = block.fillet(4.0, block.edges("|Y and >Z"));
let slots = [];
for i in 0..n {
    let x = 2.0 + pitch / 2.0 + i.to_float() * pitch;
    slots.push(box_from_corners([x - cable / 2.0, -1, height * 0.35], [x + cable / 2.0, 21.0, height + 1.0]) + cylinder([x, -1, height * 0.35], "Y", cable / 2.0, 22.0));
}
b - fuse_all(slots)
