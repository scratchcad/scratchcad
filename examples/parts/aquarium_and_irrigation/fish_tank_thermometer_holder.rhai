// Stick-on thermometer holder: 6 mm glass thermometer, 110 mm channel, 3 mm wall, two snap tabs
let tube = 6.0; // [4.0, 10.0] Thermometer diameter (mm)
let length = 110.0; // [70.0, 160.0] Length (mm)
let back = box_from_corners([-tube, 0, 0], [tube, 2.0, length]);
let tabs = [];
for z in [length * 0.2, length * 0.8] {
    tabs.push(cylinder([0, 0, z - 6.0], "Z", tube / 2.0 + 1.5, 12.0).translate([0, tube / 2.0 + 2.0, 0]) - cylinder([0, tube / 2.0 + 2.0, z - 7.0], "Z", tube / 2.0, 14.0) - box_from_corners([-tube * 0.35, tube / 2.0 + 3.0, z - 7.0], [tube * 0.35, tube * 2.0, z + 7.0]));
}
let foot = cylinder([0, tube / 2.0 + 2.0, 0], "Z", tube / 2.0 + 1.5, 3.0) - cylinder([0, tube / 2.0 + 2.0, 1.5], "Z", tube / 2.0, 3.0);
back + fuse_all(tabs) + foot
