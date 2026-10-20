// Surfboard leash plug: 20 mm cup 15 mm deep, 26 mm flange, 5 mm cross bar for the leash string
let cup = 20.0; // [16.0, 25.0] Cup diameter (mm)
let depth = 15.0; // [10.0, 20.0] Cup depth (mm)
let flange = 26.0; // [22.0, 32.0] Flange diameter (mm)
let shell = cylinder([0, 0, -depth], "Z", cup / 2.0, depth) + cylinder(flange / 2.0, 1.2);
let s = shell - cylinder([0, 0, -depth + 1.5], "Z", cup / 2.0 - 1.5, depth + 2.0);
let bar = box_centered(cup - 2.0, 5.0, 5.0).translate([0, 0, -depth + 4.0]);
s + (bar & cylinder([0, 0, -depth], "Z", cup / 2.0 - 1.0, depth)) - cylinder([-cup, 0, -depth + 4.5], "X", 1.5, cup * 2.0)
