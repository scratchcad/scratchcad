// Hot glue gun stand for a full-size gun: 100 x 70 mm base, 40 mm cradle for an 11 mm nozzle, drip cup
let length = 100.0; // [80.0, 140.0] Base length (mm)
let width = 70.0; // [50.0, 100.0] Base width (mm)
let base = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, 4.0]);
let b = base.fillet(8.0, base.edges("|Z"));
let post = box_from_corners([10.0, -15.0, 3.9], [22.0, 15.0, 40.0]) - cylinder([5.0, 0, 40.0], "X", 7.0, 25.0) - box_from_corners([5.0, -2.5, 30.0], [30.0, 2.5, 45.0]);
let cup = cylinder([65.0, 0, 3.9], "Z", 18.0, 10.0) - cylinder([65.0, 0, 5.5], "Z", 16.0, 10.0);
b + post + cup
