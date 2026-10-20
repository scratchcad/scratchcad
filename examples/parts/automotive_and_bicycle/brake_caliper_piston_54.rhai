// Brake caliper piston: 54 mm diameter 48 mm tall, 42 mm cup bore 40 mm deep, dust-boot groove 3.5 mm below the open end
let d = 54.0; // [38.0, 60.0] Piston diameter (mm)
let h = 48.0; // [35.0, 55.0] Height (mm)
let p = cylinder(d / 2.0, h).fillet(1.0, "<Z") - cylinder([0, 0, 8.0], "Z", d / 2.0 - 6.0, h);
p = p.chamfer(0.8, ">Z");
p - (cylinder([0, 0, h - 6.0], "Z", d / 2.0 + 1.0, 2.5) - cylinder([0, 0, h - 7.0], "Z", d / 2.0 - 1.5, 4.5))
