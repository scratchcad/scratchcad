// Stepped headset press adapter: three 7 mm steps of 34, 44 and 49.6 mm for EC34, ZS44 and 1.5 in cups, 16.5 mm bore for the press rod, 0.8 mm chamfers on each step
let small_d = 34.0; // [30.0, 36.0] Small step diameter (mm)
let mid_d = 44.0; // [40.0, 46.0] Middle step diameter (mm)
let large_d = 49.6; // [48.0, 56.0] Large step diameter (mm)
let step_h = 7.0; // [5.0, 10.0] Step height (mm)
const bore = 16.5;
let diameters = [large_d, mid_d, small_d];
let steps = [];
for i in 0..3 {
    let s = cylinder([0, 0, i.to_float() * step_h - 0.5], "Z", diameters[i] / 2.0, step_h + 0.5);
    steps.push(s.chamfer(0.8, s.edges(">Z")));
}
fuse_all(steps) - cylinder([0, 0, -2.0], "Z", bore / 2.0, 3.0 * step_h + 4.0)
