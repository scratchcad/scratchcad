// 623ZZ shielded miniature bearing: 3 x 10 x 4 mm, metal shields recessed 0.2 mm in both faces
let bore = 3.0; // [2.0, 8.0] Bore (mm)
let outer = 10.0; // [6.0, 22.0] Outside diameter (mm)
let width = 4.0; // [2.5, 7.0] Width (mm)
let ring_wall = 1.2; // [0.6, 3.0] Ring wall (mm)
let outer_ring = (cylinder(outer / 2.0, width) - cylinder([0, 0, -1], "Z", outer / 2.0 - ring_wall, width + 2.0)).chamfer(0.2, "%CIRCLE and (>Z or <Z)");
let inner_ring = (cylinder(bore / 2.0 + ring_wall, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0)).chamfer(0.2, "%CIRCLE and (>Z or <Z)");
let shield = cylinder(outer / 2.0 - ring_wall + 0.01, 0.3) - cylinder([0, 0, -1], "Z", bore / 2.0 + ring_wall + 0.15, 3.0);
[outer_ring + shield.translate([0, 0, 0.2]) + shield.translate([0, 0, width - 0.5]), inner_ring]
