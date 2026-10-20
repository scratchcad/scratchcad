// NEMA 17 stepper motor
let body_size = 42.3; // [42.0, 42.5] Body width (mm)
let body_length = 40.0; // [20.0, 60.0] Body length (mm)
let shaft_length = 24.0; // [10.0, 30.0] Shaft length (mm)
let shaft_d = 5.0; // [5.0, 8.0] Shaft diameter (mm)
const hole_spacing = 31.0; // NEMA 17 standard
let body = box_centered(body_size, body_size, body_length).translate([0, 0, -body_length / 2.0]);
body = body.chamfer(4.0, "|Z");
// darker end caps: a 1 mm groove 8 mm from each end
for z in [-8.0, -body_length + 8.0] {
    body -= (box_centered(body_size + 2.0, body_size + 2.0, 1.0) - box_centered(body_size - 1.0, body_size - 1.0, 3.0)).translate([0, 0, z]);
}
let boss = cylinder([0, 0, -0.1], "Z", 11.0, 2.1);
body = body + boss;
for x in [-1, 1] { for y in [-1, 1] {
    body -= cylinder([x * hole_spacing / 2.0, y * hole_spacing / 2.0, -4.0], "Z", 1.5, 5.0);
} }
let shaft = cylinder([0, 0, 1.0], "Z", shaft_d / 2.0, shaft_length + 1.0);
let flat = box_from_corners([shaft_d / 2.0 - 0.5, -5, 2.0 + shaft_length - 15.0], [10, 5, 30 + shaft_length]);
body + (shaft - flat)
