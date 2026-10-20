// Cover for a 215 x 115 mm power supply end: 50 mm deep, 2 mm walls, IEC C14 inlet cutout 27.5 x 20 mm, rocker switch 13 x 19 mm
let width = 115.0; // [80.0, 160.0] PSU width (mm)
let height = 50.0; // [30.0, 80.0] PSU height (mm)
let depth = 50.0; // [30.0, 80.0] Cover depth (mm)
let wall = 2.0; // [1.5, 2.7] Wall thickness (mm)
let cover = box(width + 2.0 * wall, depth, height + 2.0 * wall).fillet(3.0, "|Y").shell(-wall, "<Y");
cover = cover - box_centered(27.5, wall * 4.0, 20.0).translate([width * 0.3, depth - wall / 2.0, height / 2.0 + wall]);
cover = cover - box_centered(13.0, wall * 4.0, 19.0).translate([width * 0.65, depth - wall / 2.0, height / 2.0 + wall]);
for s in [-1, 1] { cover -= cylinder([width * 0.3 + s * 20.0, depth - 5.0, height / 2.0 + wall], "Y", 1.6, 10.0); }
cover
