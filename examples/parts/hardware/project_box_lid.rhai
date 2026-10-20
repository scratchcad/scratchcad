// Project box lid: 100 x 60 x 3 mm with a 1.5 mm locating lip 2 mm in from the edge and 4 countersunk M3 holes
let length = 100.0; // [40.0, 250.0] Length (mm)
let width = 60.0; // [30.0, 200.0] Width (mm)
let thickness = 3.0; // [2.0, 6.0] Thickness (mm)
let wall = 2.0; // [1.2, 4.0] Box wall thickness (mm)
let lid = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]).fillet(4.0, "|Z");
let lip = (box_centered(length - 2.0 * wall - 0.4, width - 2.0 * wall - 0.4, 3.0) - box_centered(length - 2.0 * wall - 3.4, width - 2.0 * wall - 3.4, 4.0)).translate([0, 0, -1.5 + 0.01]);
let part = lid + lip.fillet(1.0, "|Z and (>X or <X)");
for sx in [-1, 1] { for sy in [-1, 1] {
    let p = [sx * (length / 2.0 - wall - 3.5), sy * (width / 2.0 - wall - 3.5)];
    part -= cylinder([p[0], p[1], -5], "Z", 1.7, 10) + cone(1.7, 3.2, 1.51).translate([p[0], p[1], thickness - 1.5]);
} }
part
