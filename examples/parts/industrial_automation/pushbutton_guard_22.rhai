// 22 mm pushbutton guard collar: 40 mm OD 18 mm tall shroud with a 22.3 mm mounting hole and anti-rotation tab
let hole = 22.3; // [16.2, 30.5] Panel hole (mm)
let od = 40.0; // [30.0, 55.0] Guard diameter (mm)
let height = 18.0; // [10.0, 30.0] Guard height (mm)
let ring = cylinder(od / 2.0, 2.0) - cylinder([0, 0, -1], "Z", hole / 2.0, 4.0);
let shroud = cylinder([0, 0, 1.99], "Z", od / 2.0, height - 2.0) - cylinder([0, 0, 1.0], "Z", od / 2.0 - 2.5, height);
let cut = box_from_corners([-od, -8.0, height * 0.5], [-od / 4.0, 8.0, height + 1.0]);
ring + shroud - cut + box_from_corners([hole / 2.0 - 1.5, -1.6, -2.0], [hole / 2.0 + 0.01, 1.6, 0.01])
