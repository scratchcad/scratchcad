// Rosin cake holder: 45 mm round tray 8 mm deep with 2 mm walls for a 40 mm rosin cake, a 20 mm thumb notch and a friction lid lip 1.5 mm
let cake = 40.0; // [30.0, 60.0] Rosin cake diameter (mm)
let depth = 8.0; // [5.0, 15.0] Tray depth (mm)
const wall = 2.0;
let r = cake / 2.0 + 0.5;
let t = cylinder([0, 0, 0], "Z", r + wall, depth + wall) - cylinder([0, 0, wall], "Z", r, depth + 1.0);
let lip = cylinder([0, 0, depth + wall - 0.01], "Z", r + wall - 0.8, 1.5) - cylinder([0, 0, depth], "Z", r, 4.0);
t + lip - box_centered(20.0, 2.0 * wall + 2.0, depth).translate([0, r + wall / 2.0, depth / 2.0 + wall + 2.0])
