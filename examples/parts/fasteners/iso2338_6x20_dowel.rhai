// ISO 2338 m6 x 20 parallel dowel pin with one chamfered and one rounded end
let diameter = 6.0; // [1.0, 20.0] Diameter (mm)
let length = 20.0; // [4.0, 100.0] Length (mm)
let pin = cylinder(diameter / 2.0, length);
pin.chamfer(diameter * 0.12, "<Z").fillet(diameter * 0.15, ">Z")
