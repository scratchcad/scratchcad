// US single-gang electrical box: 2 x 3 in (51 x 76 mm) opening, 64 mm deep, 2 mm walls, mounting ears with 6-32 holes 83.3 mm apart
let width = 51.0; // [51.0, 105.0] Opening width (mm)
let height = 76.0; // [76.0, 90.0] Opening height (mm)
let depth = 64.0; // [40.0, 90.0] Depth (mm)
let wall = 2.0; // [1.5, 2.9] Wall thickness (mm)
let ear_centres = 83.3; // [83.3, 83.3] Device screw centres (mm)
let shell = box_centered(width + 2.0 * wall, height + 2.0 * wall, depth).translate([0, 0, -depth / 2.0]).fillet(3.0, "|Z").shell(-wall, ">Z");
let ears = [];
for s in [-1, 1] { ears.push((box_centered(14.0, 8.0, wall) + cylinder([0, 0, -wall / 2.0], "Z", 4.0, wall)).translate([0, s * (ear_centres / 2.0), -wall / 2.0 - 3.0]) - cylinder([0, s * ear_centres / 2.0, -10], "Z", 1.4, 20)); }
let knockouts = [];
for z in [-depth * 0.35, -depth * 0.7] { knockouts.push(cylinder([-width, 0, z], "X", 11.0, width * 2.0)); }
fuse_all([shell] + ears) - fuse_all(knockouts)
