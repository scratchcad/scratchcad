// Quartz clock movement dial spacer: 7.5 mm thread bore, 15 mm OD, 3 mm thick washer with anti-rotation tab
let bore = 7.6; // [5.0, 12.0] Thread bore (mm)
let od = 15.0; // [10.0, 22.0] Outside diameter (mm)
let t = 3.0; // [1.0, 6.0] Thickness (mm)
let w = cylinder(od / 2.0, t) - cylinder([0, 0, -1], "Z", bore / 2.0, t + 2.0);
w + box_from_corners([-1.0, od / 2.0 - 0.5, 0], [1.0, od / 2.0 + 2.0, t + 1.5])
