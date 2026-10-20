// Soup ladle, 120 ml: hemispherical bowl 77 mm inside diameter, 1.5 mm wall with a rolled rim, 8 mm round handle swept 280 mm up from the rim and ending in a hanging hook
let capacity = 120.0; // [30.0, 300.0] Bowl capacity (ml)
let wall = 1.5; // [1.0, 3.0] Bowl wall (mm)
let handle_diameter = 8.0; // [6.0, 12.0] Handle diameter (mm)
let handle_rise = 220.0; // [120.0, 300.0] Handle height above the rim (mm)
let r = (capacity * 1000.0 * 3.0 / (2.0 * PI())) ** (1.0 / 3.0);
let below = box_centered(4.0 * r, 4.0 * r, 2.0 * r + 4.0).translate([0, 0, -r - 2.0]);
let bowl = ((sphere(r + wall) & below) - sphere(r)) + torus(r + wall / 2.0, wall);
// handle path from the rim on -X, up and back, ending in a hook
let x0 = -r - wall / 2.0;
let path = spline([[x0, 0, -6.0], [x0 - 2.0, 0, 10.0], [x0 - 18.0, 0, handle_rise * 0.5], [x0 - 34.0, 0, handle_rise - 10.0],
                   [x0 - 30.0, 0, handle_rise + 6.0], [x0 - 18.0, 0, handle_rise + 4.0], [x0 - 16.0, 0, handle_rise - 8.0]]);
let start = path.start_point();
let profile = circle(start, path.tangent_at(0.0), handle_diameter / 2.0);
let handle = face(profile).sweep(path);
let tip = sphere(path.end_point(), handle_diameter / 2.0);
bowl + handle + tip
