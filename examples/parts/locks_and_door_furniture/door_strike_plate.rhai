// Mortice latch strike plate: 120 x 25 x 1.5 mm with 3 mm end radii, 22 x 12 mm latch aperture, 22 x 10 mm deadbolt aperture and two countersunk 4.5 mm screw holes, plus a 12 mm flat strike lip
let length = 120.0; // [100.0, 175.0] Plate length (mm)
let width = 25.0; // [20.0, 32.0] Plate width (mm)
const t = 1.5;
let p = box_from_corners([0, 0, 0], [width, length, t]);
let p = p.fillet(3.0, p.edges("|Z"));
let lip = box_from_corners([-12.0, length / 2.0 - 25.0, 0], [0.01, length / 2.0 + 5.0, t]);
let holes = [box_from_corners([width / 2.0 - 6.0, length / 2.0 - 21.0, -1.0], [width / 2.0 + 6.0, length / 2.0 + 1.0, t + 1.0]), box_from_corners([width / 2.0 - 5.0, length / 2.0 + 14.0, -1.0], [width / 2.0 + 5.0, length / 2.0 + 36.0, t + 1.0])];
for y in [10.0, length - 10.0] {
    holes.push(cylinder([width / 2.0, y, -1.0], "Z", 2.25, t + 2.0));
    holes.push(cone(2.25, 4.5, 2.25).translate([width / 2.0, y, t - 0.75]));
}
p + lip - fuse_all(holes)
