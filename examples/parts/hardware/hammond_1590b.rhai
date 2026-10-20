// Hammond 1590B diecast box: 112.4 x 60.5 x 31 mm outside, 2.5 mm walls, slight draft, 4 lid screw bosses
let length = 112.4; // [60.0, 200.0] Length (mm)
let width = 60.5; // [40.0, 150.0] Width (mm)
let height = 31.0; // [15.0, 80.0] Height (mm)
let wall = 2.5; // [1.5, 5.0] Wall thickness (mm)
let corner_r = 6.0; // [2.0, 12.0] Corner radius (mm)
let shell = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(corner_r, "|Z").fillet(1.5, "<Z");
shell = shell.shell(-wall, ">Z");
let bosses = [];
for sx in [-1, 1] { for sy in [-1, 1] {
    let p = [sx * (length / 2.0 - wall - 3.5), sy * (width / 2.0 - wall - 3.5), wall - 0.1];
    bosses.push(cylinder(p, "Z", 3.5, height - wall - 1.0) - cylinder([p[0], p[1], p[2] + 3.0], "Z", 1.25, height));
} }
fuse_all([shell] + bosses)
