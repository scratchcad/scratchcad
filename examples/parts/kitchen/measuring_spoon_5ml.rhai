// 1 teaspoon (5 ml) measuring spoon: hemispherical bowl 26.7 mm inside diameter holding 15 ml level-full, 1.5 mm wall, 90 mm flat handle 12 mm wide 3 mm thick with a hanging hole
let capacity = 5.0; // [1.0, 60.0] Capacity (ml)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let handle_length = 90.0; // [50.0, 150.0] Handle length (mm)
let handle_width = 12.0; // [8.0, 25.0] Handle width (mm)
let handle_thickness = 3.0; // [2.0, 5.0] Handle thickness (mm)
// a hemisphere holds 2/3 pi r^3
let r = (capacity * 1000.0 * 3.0 / (2.0 * PI())) ** (1.0 / 3.0);
print(`bowl inside radius ${r} mm`);
let below = box_centered(4.0 * r, 4.0 * r, 2.0 * r + 2.0 * wall).translate([0, 0, -r - wall]);
let bowl = (sphere(r + wall) & below) - sphere(r);
let x0 = r + 0.3;
let handle = box_from_corners([x0, -handle_width / 2.0, -handle_thickness], [r + handle_length, handle_width / 2.0, 0]);
handle = handle.fillet(handle_width / 2.0 - 0.1, "|Z and >X");
handle -= cylinder([r + handle_length - handle_width / 2.0, 0, -handle_thickness - 1.0], "Z", 3.0, handle_thickness + 2.0);
bowl + handle
