// Pottery wheel bat pin: 3/8-16 stud 15 mm, 9.5 mm pin 12 mm tall, 16 mm flange 3 mm
let pin = 9.5; // [6.0, 12.0] Pin diameter (mm)
let pin_h = 12.0; // [8.0, 18.0] Pin height (mm)
let p = cylinder(8.0, 3.0) + cylinder([0, 0, 2.99], "Z", pin / 2.0, pin_h) + cylinder([0, 0, -15.0], "Z", 4.75, 15.01);
p.chamfer(1.0, p.edges(">Z"))
