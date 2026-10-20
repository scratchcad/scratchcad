// Anti-vibration printer foot: 40 mm round foot 15 mm tall, cupped to take a 2020 extrusion end, M5 counterbored centre hole
let diameter = 40.0; // [25.0, 60.0] Foot diameter (mm)
let height = 15.0; // [8.0, 30.0] Height (mm)
let foot = cone(diameter / 2.0, diameter / 2.0 - 3.0, height).fillet(2.0, "<Z");
foot = foot - box_centered(20.4, 20.4, 6.0).translate([0, 0, height - 2.99]);
foot - cylinder([0, 0, -1], "Z", 2.6, height + 2.0) - cylinder([0, 0, -1], "Z", 4.6, 6.0)
