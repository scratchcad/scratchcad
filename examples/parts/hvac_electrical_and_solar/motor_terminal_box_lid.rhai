// IP55 motor terminal box lid: 110 x 110 mm, 18 mm deep, 2.5 mm walls, 8 mm corner radius, four 5.5 mm screw bosses, gasket groove in the rim
let size = 110.0; // [60.0, 200.0] Lid size (mm)
let depth = 18.0; // [10.0, 40.0] Lid depth (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let corner = 8.0; // [4.0, 15.0] Corner radius (mm)
const screw = 5.5;
let c = min(corner, size / 6.0);
let outer = box_centered(size, size, depth).translate([0, 0, depth / 2.0]).fillet(c, "|Z").fillet(2.0, ">Z");
let inner = box_centered(size - 2.0 * wall, size - 2.0 * wall, depth).translate([0, 0, depth / 2.0 - wall]).fillet(c - wall, "|Z");
let lid = outer - inner;
let off = size / 2.0 - wall - 4.0;
let bosses = [];
let holes = [];
for x in [-1.0, 1.0] {
    for y in [-1.0, 1.0] {
        bosses.push(cylinder([x * off, y * off, 0.5], "Z", 5.5, depth - 1.0));
        holes.push(cylinder([x * off, y * off, -1], "Z", screw / 2.0, depth + 2.0));
        holes.push(cylinder([x * off, y * off, depth - 2.5], "Z", 5.0, 3.0));
    }
}
lid = fuse_all([lid] + bosses) - fuse_all(holes);
let groove = (box_centered(size - wall - 0.4, size - wall - 0.4, 3.0).fillet(c - wall / 2.0 - 0.2, "|Z")
    - box_centered(size - 2.0 * wall + 0.6, size - 2.0 * wall + 0.6, 4.0).fillet(c - wall + 0.3, "|Z"));
lid - groove.translate([0, 0, 0.0])
