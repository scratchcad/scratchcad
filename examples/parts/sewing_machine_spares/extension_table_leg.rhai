// Folding extension table leg: 16 mm square column, 70 mm from the floor to the pivot centre, with 2 mm rounded edges, 24 mm foot pad 4 mm thick with a 1 mm chamfer, 19 mm pivot knuckle across the top with a 4.2 mm pin hole
let height = 70.0; // [40.0, 120.0] Leg height (mm)
let column = 16.0; // [12.0, 22.0] Column size (mm)
let foot_d = 24.0; // [20.0, 34.0] Foot diameter (mm)
let pin_d = 4.2; // [3.0, 6.0] Pivot pin hole (mm)
const foot_t = 4.0;
let fd = max(foot_d, column * 1.5);
let col = box_centered(column, column, height - foot_t).translate([0, 0, foot_t + (height - foot_t) / 2.0 - 0.5]);
let col = col.fillet(2.0, col.edges("|Z"));
let foot = cylinder(fd / 2.0, foot_t);
let foot = foot.chamfer(1.0, foot.edges("<Z"));
let knuckle = cylinder([-column / 2.0, 0, height], "X", column / 2.0 + 1.5, column);
fuse_all([col, foot, knuckle]) - cylinder([-column, 0, height], "X", pin_d / 2.0, 2.0 * column)
