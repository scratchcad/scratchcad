// Letter plate: 250 x 70 x 3 mm face with a 220 x 40 mm opening, separate 225 x 45 mm flap hinged on a 5 mm rod along its top
let w = 250.0; // [200.0, 330.0] Plate width (mm)
let h = 70.0; // [55.0, 90.0] Plate height (mm)
let plate = box_centered(w, h, 3.0).translate([0, 0, 1.5]).fillet(5.0, "|Z").chamfer(0.8, ">Z") - box_centered(w - 30.0, h - 30.0, 10.0).fillet(3.0, "|Z");
for x in [-w / 2.0 + 8.0, w / 2.0 - 8.0] { plate -= cylinder([x, 0, -1], "Z", 2.25, 5.0); }
let flap = box_from_corners([-(w - 25.0) / 2.0, -h / 2.0 + 10.0, 3.5], [(w - 25.0) / 2.0, h / 2.0 - 15.0, 5.5]) + cylinder([-(w - 25.0) / 2.0, h / 2.0 - 15.0, 6.0], "X", 2.5, w - 25.0);
compound([plate, flap])
