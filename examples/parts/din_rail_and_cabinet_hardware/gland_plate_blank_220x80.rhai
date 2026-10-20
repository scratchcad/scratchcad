// Blank gland plate for a cabinet floor: 220 x 80 mm, 2 mm sheet with a 10 mm folded rim, four 5.5 mm fixing holes 8 mm from the corners, to be drilled for glands on site
let length = 220.0; // [100.0, 400.0] Plate length (mm)
let width = 80.0; // [50.0, 150.0] Plate width (mm)
let thickness = 2.0; // [1.5, 3.0] Sheet thickness (mm)
let rim = 10.0; // [5.0, 20.0] Folded rim depth (mm)
const hole_d = 5.5;
let outer = box_centered(length, width, rim).translate([0, 0, rim / 2.0]);
let inner = box_centered(length - 2.0 * thickness, width - 2.0 * thickness, rim).translate([0, 0, rim / 2.0 - thickness]);
let plate = outer - inner;
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        holes.push(cylinder([sx * (length / 2.0 - 8.0), sy * (width / 2.0 - 8.0), rim - thickness - 1.0], "Z", hole_d / 2.0, thickness + 2.0));
    }
}
(plate - fuse_all(holes)).rotate_x(180.0).translate([0, 0, rim])
