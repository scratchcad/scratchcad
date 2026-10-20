// Curtain ring for a 38 mm pole: 5 mm wire ring 44 mm across with an 8 mm eyelet below for the hook
let pole = 38.0; // [20.0, 60.0] Pole diameter (mm)
let wire = 2.5; // [1.5, 4.0] Wire radius (mm)
let R = pole / 2.0 + wire + 0.5;
let ring = torus(R, wire).rotate_x(90.0);
let eye = torus(4.0, 1.2).rotate_x(90.0).translate([0, 0, -R - 4.0 - wire + 0.5]);
ring + eye
