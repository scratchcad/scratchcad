// Lever door handle: 52 mm rose 9 mm thick, 120 mm lever 18 mm diameter swept on a bend, 8 mm square spindle hole
let rose_d = 52.0; // [40.0, 70.0] Rose diameter (mm)
let rose_t = 9.0; // [5.0, 15.0] Rose thickness (mm)
let lever_l = 120.0; // [80.0, 160.0] Lever length (mm)
let grip_d = 18.0; // [12.0, 25.0] Grip diameter (mm)
let neck_l = 50.0; // [30.0, 70.0] Neck length (mm)
let rose = cylinder(rose_d / 2.0, rose_t).fillet(3.0, ">Z");
let path = wire([line([0, 0, rose_t - 1.0], [0, 0, neck_l - 15.0]), arc([0, 0, neck_l - 15.0], [4.4, 0, neck_l - 4.4], [15.0, 0, neck_l]), line([15.0, 0, neck_l], [lever_l, 0, neck_l])]);
let lever = circle([0, 0, rose_t - 1.0], "Z", grip_d / 2.0).to_face().sweep(path);
let tip = sphere([lever_l, 0, neck_l], grip_d / 2.0);
fuse_all([rose, lever, tip]) - box_centered(8.0, 8.0, 40.0)
