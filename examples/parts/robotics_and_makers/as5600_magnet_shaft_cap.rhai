// Diametric magnet holder for an AS5600 magnetic encoder: press-fit cap for a 5 mm shaft, 12 mm OD, 10 mm long, 6.1 x 2.6 mm magnet pocket on the end, 1 mm air-gap rim, M2 set screw
let shaft_d = 5.0; // [3.0, 8.0] Shaft diameter (mm)
let od = 12.0; // [9.0, 20.0] Outside diameter (mm)
let length = 10.0; // [6.0, 20.0] Length (mm)
let magnet_d = 6.1; // [4.0, 10.0] Magnet diameter (mm)
let magnet_t = 2.6; // [1.0, 4.0] Magnet thickness (mm)
let r = max(od, max(shaft_d, magnet_d) + 3.0) / 2.0;
let c = cylinder(r, length).chamfer(0.5, ">Z or <Z");
c -= cylinder([0, 0, -1], "Z", shaft_d / 2.0, length - magnet_t - 1.0 + 1.0);
c -= cylinder([0, 0, length - magnet_t], "Z", magnet_d / 2.0, magnet_t + 1.0);
c -= cylinder([0, 0, (length - magnet_t - 1.0) / 2.0], "X", 0.8, r + 1.0);
c
