// Cast corner bracket for 2020 extrusion: 20 x 20 x 20 mm, 4 mm walls, triangular web, 5.5 mm slots on both faces
let size = 20.0; // [15.0, 40.0] Leg length (mm)
let width = 20.0; // [15.0, 40.0] Width (mm)
let wall = 4.0; // [2.5, 6.0] Wall thickness (mm)
let legs = box(size, width, wall) + box(wall, width, size);
let web = polygon("XZ", [[wall - 0.1, wall - 0.1], [size, wall - 0.1], [wall - 0.1, size]]).to_face().extrude([0, wall, 0]).translate([0, (width - wall) / 2.0 + wall, 0]);
let part = legs + web;
part = part - (box_centered(6.0, 5.5, wall * 3.0) + cylinder([-3, 0, -wall], "Z", 2.75, wall * 3) + cylinder([3, 0, -wall], "Z", 2.75, wall * 3)).translate([size * 0.6, width / 2.0, 0]);
part - (box_centered(wall * 3.0, 5.5, 6.0) + cylinder([-wall, 0, -3], "X", 2.75, wall * 3) + cylinder([-wall, 0, 3], "X", 2.75, wall * 3)).translate([0, width / 2.0, size * 0.6])
