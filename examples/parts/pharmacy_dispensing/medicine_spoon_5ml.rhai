// 5 ml medicine spoon: hemispherical bowl holding 5 ml to the brim (13.4 mm inner radius) with a 1.5 mm wall, on a 100 mm handle 12 mm wide and 3 mm thick level with the brim, 4 mm rounded handle end with a 4 mm hanging hole
let dose_ml = 5.0; // [2.5, 15.0] Bowl capacity (ml)
let wall = 1.5; // [1.0, 2.5] Bowl wall (mm)
let handle_len = 100.0; // [70.0, 140.0] Handle length (mm)
let handle_w = 12.0; // [8.0, 16.0] Handle width (mm)
const handle_t = 3.0;
let ri = (dose_ml * 1000.0 * 3.0 / (2.0 * PI())) ** (1.0 / 3.0);
print(`inner radius ${ri}`);
let ro = ri + wall;
let bowl = sphere(ro) - sphere(ri) - box_from_corners([-ro - 1.0, -ro - 1.0, 0], [ro + 1.0, ro + 1.0, ro + 1.0]);
let handle = box_from_corners([ri + 0.3, -handle_w / 2.0, -handle_t], [ri + handle_len, handle_w / 2.0, 0]);
let handle = handle.fillet(min(4.0, handle_w / 2.0 - 0.5), handle.edges("|Z and >X"));
let handle = handle - cylinder([ri + handle_len - 7.0, 0, -handle_t - 1.0], "Z", 2.0, handle_t + 2.0);
bowl + handle
