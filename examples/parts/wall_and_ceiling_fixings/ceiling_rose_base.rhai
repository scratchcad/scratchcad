// Ceiling rose base: 85 mm dia 20 mm tall shell, 2 mm walls, with a 20 mm cable entry, two 4.5 mm fixing slots on 50 mm centres and a 30 x 8 mm terminal block bridge
let dia = 85.0; // [70.0, 110.0] Rose diameter (mm)
let height = 20.0; // [15.0, 30.0] Rose height (mm)
const wall = 2.0;
let shell = cylinder([0, 0, 0], "Z", dia / 2.0, height) - cylinder([0, 0, wall], "Z", dia / 2.0 - wall, height);
let bridge = box_from_corners([-15.0, -4.0, wall - 0.01], [15.0, 4.0, wall + 8.0]);
let cuts = [cylinder([0, 15.0, -1.0], "Z", 10.0, wall + 2.0), box_from_corners([-27.5, -2.25, -1.0], [-22.5, 2.25, wall + 1.0]) + cylinder([-27.5, 0, -1.0], "Z", 2.25, wall + 2.0), box_from_corners([22.5, -2.25, -1.0], [27.5, 2.25, wall + 1.0]) + cylinder([27.5, 0, -1.0], "Z", 2.25, wall + 2.0)];
shell + bridge - fuse_all(cuts)
