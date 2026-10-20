// Pendulum crutch: 60 mm arm 3 mm thick, 4 mm pallet arbor boss with set screw, 2.5 mm fork slot at the end
let length = 60.0; // [40.0, 100.0] Crutch length (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let arm = box_from_corners([-2.5, 0, 0], [2.5, length, t]);
let boss = cylinder([0, 0, 0], "Z", 5.0, t + 4.0) - cylinder([0, 0, -1], "Z", 2.0, t + 6.0) - cylinder([-6.0, 0, t + 2.0], "X", 0.8, 12.0);
let fork = box_from_corners([-4.0, length - 8.0, 0], [4.0, length, t]) - box_from_corners([-1.25, length - 6.0, -1], [1.25, length + 1.0, t + 1.0]);
arm + boss + fork
