// Gimbal counterweight slider for a 15 mm rod or Arca rail: 40 x 30 x 25 mm steel block with a 15.2 mm rod bore through, 1.5 mm split slot to the side, M4 thumb-screw hole (3.3 mm) across the split, and two 1/4-20 tapped holes (5.1 mm core) on top for stacking extra weights
let length = 40.0; // [20.0, 80.0] Weight length (mm)
let width = 30.0; // [26.0, 50.0] Weight width (mm)
let height = 25.0; // [24.0, 40.0] Weight height (mm)
const rod_d = 15.2;
const zc = 11.0;
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(1.5, block.edges("|X"));
let bore = cylinder([-length / 2.0 - 1.0, 0, zc], "X", rod_d / 2.0, length + 2.0);
let split = box_from_corners([-length / 2.0 - 1.0, 0, zc - 0.75], [length / 2.0 + 1.0, width / 2.0 + 1.0, zc + 0.75]);
let screw = cylinder([0, width / 2.0 - 3.5, -1.0], "Z", 1.65, height + 2.0);
let taps = [];
for s in [-1.0, 1.0] {
    taps.push(cylinder([s * (length / 2.0 - 8.0), -width / 4.0, height - 6.0], "Z", 2.55, 7.0));
}
block - bore - split - screw - fuse_all(taps)
