// Desk cable organizer: 120 x 20 x 15 mm block with 5 keyhole cable slots of 6 mm and an adhesive base
let length = 120.0; // [60.0, 200.0] Length (mm)
let width = 20.0; // [12.0, 40.0] Depth (mm)
let height = 15.0; // [10.0, 30.0] Height (mm)
let slots = 5; // [2, 10] Cable slots
let cable_d = 6.0; // [3.0, 12.0] Cable diameter (mm)
let block = box(length, width, height).fillet(3.0, "|Z").fillet(2.0, ">Z");
let pitch = length / slots.to_float();
for i in 0..slots {
    let x = pitch / 2.0 + i.to_float() * pitch;
    block -= cylinder([x, -1, height * 0.5], "Y", cable_d / 2.0, width + 2.0);
    block -= box_from_corners([x - cable_d * 0.35, -1, height * 0.5], [x + cable_d * 0.35, width + 1, height + 1]);
}
block
