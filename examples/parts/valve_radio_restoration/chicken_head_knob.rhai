// Chicken-head pointer knob: 38 mm pointer 12 mm wide on a 20 mm skirt 8 mm tall, total 16 mm, with a 6.35 mm (1/4 inch) shaft bore 12 mm deep and an M3 grub screw hole
let length = 38.0; // [28.0, 50.0] Pointer length (mm)
let shaft = 6.35; // [6.0, 6.5] Shaft diameter (mm)
let skirt = cylinder([0, 0, 0], "Z", 10.0, 8.0);
let pointer = face(polygon([[-length * 0.3, -6.0, 0], [length * 0.55, -2.0, 0], [length * 0.7, 0, 0], [length * 0.55, 2.0, 0], [-length * 0.3, 6.0, 0]])).extrude([0, 0, 8.0]).translate([0, 0, 7.99]);
let k = skirt + pointer;
k - cylinder([0, 0, -1.0], "Z", shaft / 2.0 + 0.05, 13.0) - cylinder([0, -12.0, 4.0], "Y", 1.25, 12.0)
