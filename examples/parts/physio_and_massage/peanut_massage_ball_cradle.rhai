// Peanut massage ball cradle: 160 x 80 x 30 mm base with two 65 mm ball cups 15 mm deep on 70 mm centres, so a peanut ball can rest under the spine
let ball = 65.0; // [50.0, 80.0] Ball diameter (mm)
let pitch = 70.0; // [55.0, 90.0] Ball spacing (mm)
let length = pitch + ball + 25.0;
let b = box_centered(length, ball + 15.0, 30.0).translate([0, 0, 15.0]);
let b = b.fillet(10.0, b.edges("|Z"));
b - sphere([-pitch / 2.0, 0, 30.0 + ball / 2.0 - 15.0], ball / 2.0) - sphere([pitch / 2.0, 0, 30.0 + ball / 2.0 - 15.0], ball / 2.0)
