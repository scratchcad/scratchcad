// Snap-fit box with lid, 60 x 40 x 25 mm: 1.6 mm walls and floor, 4 mm corner radius, lid with a 5 mm inner lip carrying four snap bumps that click into 0.5 mm grooves in the box walls
let length = 60.0; // [30.0, 120.0] Box length (mm)
let width = 40.0; // [20.0, 80.0] Box width (mm)
let height = 25.0; // [10.0, 60.0] Box height (mm)
let wall = 1.6; // [1.0, 3.0] Wall thickness (mm)
let corner = 4.0; // [2.0, 10.0] Corner radius (mm)
let lip = 5.0; // [3.0, 8.0] Lid lip depth (mm)
let rc = max(corner, wall + 0.6);
let box_body = box_centered(length, width, height).fillet(rc, "|Z").translate([0, 0, height / 2.0]);
let cavity = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).fillet(rc - wall, "|Z").translate([0, 0, height / 2.0 + wall]);
box_body = box_body - cavity;
// snap grooves on the inside of the long walls
let gz = height - lip / 2.0;
let grooves = [];
for sy in [-1.0, 1.0] {
    grooves.push(box_centered(length * 0.4, 1.0, 1.0).translate([0, sy * (width / 2.0 - wall), gz]));
}
box_body = box_body - compound(grooves);
// lid: plate plus an inner lip 0.15 mm clear of the walls, with bumps facing the grooves
let lid_z = height + 6.0;
let plate = box_centered(length, width, 2.0).fillet(rc, "|Z").fillet(0.8, ">Z").translate([0, 0, lid_z + 1.0]);
let lip_outer = box_centered(length - 2.0 * wall - 0.3, width - 2.0 * wall - 0.3, lip + 0.1).fillet(rc - wall - 0.15, "|Z");
let lip_inner = box_centered(length - 4.0 * wall, width - 4.0 * wall, lip + 2.0).fillet(max(rc - 2.0 * wall, 0.5), "|Z");
let lid_lip = (lip_outer - lip_inner).translate([0, 0, lid_z - lip / 2.0 + 0.05]);
let bumps = [];
for sy in [-1.0, 1.0] {
    bumps.push(cylinder([-length * 0.18, sy * (width / 2.0 - wall - 0.15), lid_z - lip / 2.0], "X", 0.45, length * 0.36));
}
let lid = fuse_all([plate, lid_lip] + bumps);
[box_body, lid]
