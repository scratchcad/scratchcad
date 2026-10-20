// 4-bolt guitar neck plate: 64 x 51 mm with 6 mm corner radii, 4.5 mm thick, four 4.4 mm countersunk holes on a 44 x 33 mm pattern, and a 1 mm top edge chamfer
let length = 64.0; // [55.0, 70.0] Plate length (mm)
let width = 51.0; // [44.0, 56.0] Plate width (mm)
const t = 4.5;
let p = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = p.fillet(6.0, p.edges("|Z"));
let p = p.chamfer(1.0, p.edges(">Z"));
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] {
    holes.push(cylinder([sx * (length / 2.0 - 10.0), sy * (width / 2.0 - 9.0), -1.0], "Z", 2.2, t + 2.0));
    holes.push(cone(2.2, 4.4, 2.2).translate([sx * (length / 2.0 - 10.0), sy * (width / 2.0 - 9.0), t - 2.19]));
} }
p - fuse_all(holes)
