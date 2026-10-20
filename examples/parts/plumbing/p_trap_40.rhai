// 40 mm sink P-trap: 40 mm tube with 2 mm wall swept through a U-bend of 45 mm radius and a 90 degree outlet
let tube_d = 40.0; // [30.0, 50.0] Tube OD (mm)
let wall = 2.0; // [1.5, 3.5] Wall (mm)
let bend_r = 45.0; // [35.0, 80.0] U-bend radius (mm)
let rise = 80.0; // [40.0, 150.0] Inlet rise (mm)
let outlet = 120.0; // [60.0, 200.0] Outlet length (mm)
let path = wire([line([0, 0, rise], [0, 0, 0]), arc([0, 0, 0], [bend_r, 0, -bend_r], [2.0 * bend_r, 0, 0]), line([2.0 * bend_r, 0, 0], [2.0 * bend_r, 0, bend_r * 0.6]),
    arc([2.0 * bend_r, 0, bend_r * 0.6], [2.0 * bend_r + bend_r * 0.29, 0, bend_r * 0.6 + bend_r * 0.71], [3.0 * bend_r, 0, bend_r * 1.6]), line([3.0 * bend_r, 0, bend_r * 1.6], [3.0 * bend_r + outlet, 0, bend_r * 1.6])]);
let ring = face(circle([0, 0, rise], "Z", tube_d / 2.0), [circle([0, 0, rise], "Z", tube_d / 2.0 - wall)]);
ring.sweep(path)
