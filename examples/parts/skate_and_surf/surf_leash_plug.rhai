// Surfboard leash plug: 19 mm cup 12 mm deep with a 25 mm flush flange 1.5 mm thick and a 3 mm cross pin for the leash string
let cup_d = 19.0; // [16.0, 22.0] Cup OD (mm)
let depth = 12.0; // [10.0, 16.0] Cup depth (mm)
const flange_d = 25.0;
const wall = 1.5;
let cup = cylinder([0, 0, -depth], "Z", cup_d / 2.0, depth + 0.01) + cylinder([0, 0, 0], "Z", flange_d / 2.0, 1.5);
let cup = cup - cylinder([0, 0, -depth + wall], "Z", cup_d / 2.0 - wall, depth + 1.0);
let pin = cylinder([-cup_d / 2.0 + 0.5, 0, -depth / 2.0], "X", 1.5, cup_d - 1.0);
cup + pin
