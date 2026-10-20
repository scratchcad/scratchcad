// CO2 bubble counter: 18 mm tube 55 mm long with 4 mm tube barbs top and bottom-side and inner dip tube
let od = 18.0; // [12.0, 25.0] Body diameter (mm)
let height = 55.0; // [40.0, 80.0] Body height (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let body = cylinder(od / 2.0, height);
let shell = body - cylinder([0, 0, wall], "Z", od / 2.0 - wall, height - 2.0 * wall);
let top_barb = cylinder([0, 0, height - 0.01], "Z", 2.4, 10.0);
let side_barb = cylinder([0, 0, 8.0], "X", 2.4, od / 2.0 + 10.0);
let d = cylinder([0, 0, 6.0], "Z", 2.0, height - 6.0 - wall + 0.01) + cylinder([0, 0, 8.0], "X", 2.0, od / 2.0 - wall + 0.01);
shell + top_barb + side_barb + d - cylinder([0, 0, 7.0], "Z", 1.2, height + 12.0) - cylinder([1.0, 0, 8.0], "X", 1.2, od / 2.0 + 12.0)
