// Tack room bridle hook: 80 mm half-moon saddle 20 mm wide so the headstall keeps its shape, 50 mm stem, wall plate with 2 holes
let radius = 40.0; // [25.0, 60.0] Half-moon radius (mm)
let width = 20.0; // [12.0, 30.0] Width (mm)
let t = 5.0; // [3.0, 8.0] Shell thickness (mm)
let moon = (cylinder([0, 0, 0], "Y", radius, width) - cylinder([0, -1, 0], "Y", radius - t, width + 2.0)) & box_from_corners([-radius, -1, 0], [radius, width + 1.0, radius + 1.0]);
let plate = box_from_corners([-15.0, width - 0.01, -60.0], [15.0, width + 4.0, 10.0]);
moon + box_from_corners([-6.0, 0, -50.0], [6.0, width, radius - 1.0]) + plate - cylinder([0, width - 1.0, -40.0], "Y", 2.5, 7.0) - cylinder([0, width - 1.0, 0], "Y", 2.5, 7.0)
