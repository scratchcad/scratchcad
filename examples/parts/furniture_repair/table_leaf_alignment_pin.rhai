// Table leaf alignment pin and socket: 10 mm pin 15 mm proud on a 22 mm flange 3 mm, 2 screw holes (pin half)
let pin = 10.0; // [6.0, 14.0] Pin diameter (mm)
let proud = 15.0; // [8.0, 25.0] Pin projection (mm)
let flange = 22.0; // [16.0, 35.0] Flange diameter (mm)
let f = cylinder(flange / 2.0, 3.0) + box_centered(flange + 16.0, 12.0, 3.0).translate([0, 0, 1.5]);
let ff = f.fillet(4.0, f.edges("|Z").filter(|e| e.center().x.abs() > flange / 2.0));
let p = cylinder([0, 0, 2.99], "Z", pin / 2.0, proud);
let pp = p.chamfer(1.5, p.edges(">Z"));
ff + pp - cylinder([-flange / 2.0 - 4.0, 0, -1], "Z", 1.75, 5.0) - cylinder([flange / 2.0 + 4.0, 0, -1], "Z", 1.75, 5.0)
