// Tapered square table leg: 50 mm at the top to 30 mm at the foot, 720 mm tall, two 10 x 60 mm apron mortises 16 mm deep
let h = 720.0; // [400.0, 900.0] Height (mm)
let top = 50.0; // [35.0, 80.0] Top size (mm)
let foot = 30.0; // [20.0, 60.0] Foot size (mm)
let leg = loft([rect(plane([0, 0, 0], "Z"), foot, foot), rect(plane([0, 0, h], "Z"), top, top)], true);
let mortise = box_from_corners([top / 2.0 - 16.0, -5.0, h - 80.0], [top / 2.0 + 1.0, 5.0, h - 20.0]);
leg - mortise - mortise.rotate("Z", 90.0)
