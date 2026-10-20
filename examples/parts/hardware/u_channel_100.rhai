// Aluminium U-channel 25 x 15 x 2 mm, 100 mm long, with inside corner radii
let width = 25.0; // [10.0, 80.0] Outside width (mm)
let height = 15.0; // [8.0, 60.0] Outside height (mm)
let thickness = 2.0; // [1.0, 6.0] Wall thickness (mm)
let length = 100.0; // [20.0, 1000.0] Length (mm)
let outer = box_centered(width, length, height).translate([0, 0, height / 2.0]);
let inner = box_centered(width - 2.0 * thickness, length + 2.0, height).translate([0, 0, height / 2.0 + thickness]);
(outer - inner).fillet(thickness * 0.5, "|Y and not (>Z or <Z) and not (>X or <X)")
