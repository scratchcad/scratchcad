// Thorlabs CP33/M 30 mm cage plate: 41 mm square, 8.9 mm thick, SM1 (1.035"-40) threaded bore (shown as its 25.6 mm minor bore), four 6 mm rod bores on a 30 mm square with 4-40 locking set screws, M4 mounting hole
let plate_size = 41.0; // [36.0, 50.0] Plate width (mm)
let thickness = 8.9; // [6.0, 15.0] Plate thickness (mm)
let rod_spacing = 30.0; // [28.0, 35.0] Rod spacing (mm)
let rod_diameter = 6.0; // [4.0, 6.5] Rod bore diameter (mm)
let corner_radius = 3.0; // [0.5, 5.0] Corner radius (mm)
const r_minor = 12.8;
let plate = box_centered(plate_size, plate_size, thickness).translate([0, 0, thickness / 2.0]).fillet(corner_radius, "|Z");
plate = plate - cylinder([0, 0, -1.0], "Z", r_minor, thickness + 2.0);
plate = plate.chamfer(0.4, plate.edges("%CIRCLE").filter(|e| (e.radius() - r_minor).abs() < 0.01));
let h = rod_spacing / 2.0;
for x in [-h, h] {
    for y in [-h, h] {
        let side = if x > 0.0 { 1.0 } else { -1.0 };
        // rod bore, and a set screw from the side edge into it
        plate -= cylinder([x, y, -1], "Z", rod_diameter / 2.0, thickness + 2.0)
            + cylinder([side * (plate_size / 2.0 + 1.0), y, thickness / 2.0], vec3(-side, 0.0, 0.0), 1.1, plate_size / 2.0 - h + 1.5);
    }
}
// M4 tapped mounting hole in the bottom edge
plate - cylinder([0, -plate_size / 2.0 - 1.0, thickness / 2.0], "Y", 1.65, 7.0)
