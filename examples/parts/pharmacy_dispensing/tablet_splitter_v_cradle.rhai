// Tablet splitter cradle: 60 x 34 x 14 mm block with a 90 degree V groove 6 mm deep along its length to centre round and oval tablets, a 0.8 mm blade slot across the middle 4 mm below the groove, and an 8 mm hinge boss along the back edge with a 3 mm pin hole
let length = 60.0; // [45.0, 80.0] Block length (mm)
let width = 34.0; // [26.0, 44.0] Block width (mm)
let height = 14.0; // [10.0, 20.0] Block height (mm)
let groove_depth = 6.0; // [3.0, 8.0] V groove depth (mm)
let slot_w = 0.8; // [0.5, 1.5] Blade slot width (mm)
const boss_r = 4.0;
const pin_r = 1.5;
let d = groove_depth;
let block = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, length, height]);
let boss = cylinder([-width / 2.0, length, height], "X", boss_r, width);
let body = block + boss;
let groove = polygon([[-d - 1.0, -1.0, height + 1.0], [d + 1.0, -1.0, height + 1.0], [0, -1.0, height - d]]).to_face().extrude([0, length - 6.0, 0]);
let slot_bottom = max(2.0, height - d - 4.0);
body - fuse_all([
    groove,
    box_from_corners([-width / 2.0 - 1.0, length / 2.0 - slot_w / 2.0, slot_bottom], [width / 2.0 + 1.0, length / 2.0 + slot_w / 2.0, height + 1.0]),
    cylinder([-width / 2.0 - 1.0, length, height], "X", pin_r, width + 2.0),
])
