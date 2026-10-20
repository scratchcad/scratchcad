// Medical equipment rail clamp for the standard 25 x 10 mm wall rail: 50 mm wide body sliding on from the end, 3 mm lips behind the rail edges, M8 thumbscrew hole (6.8 mm tap) through the front and a vertical 16.5 mm socket for an accessory post
let width = 50.0; // [35.0, 70.0] Clamp width (mm)
let post_d = 16.5; // [10.0, 22.0] Accessory post diameter (mm)
const rail_h = 25.0;
const rail_t = 10.0;
const lip = 3.0;
const t = 6.0;
let front = rail_t + 0.4 + t;
let body = box_from_corners([-width / 2.0, -3.0, -rail_h / 2.0 - t], [width / 2.0, front, rail_h / 2.0 + t]);
body = body - box_from_corners([-width / 2.0 - 1.0, 0, -rail_h / 2.0 - 0.2], [width / 2.0 + 1.0, rail_t + 0.4, rail_h / 2.0 + 0.2]);
body = body - box_from_corners([-width / 2.0 - 1.0, -4.0, -rail_h / 2.0 + lip], [width / 2.0 + 1.0, 0.5, rail_h / 2.0 - lip]);
let ps = post_d / 2.0 + 5.0;
let yc = front + ps - 1.0;
body = body + cylinder([0, yc, -rail_h / 2.0 - t], "Z", ps, rail_h + 2.0 * t);
body = body - cylinder([0, yc, -rail_h / 2.0 - t + 5.0], "Z", post_d / 2.0, rail_h + 2.0 * t);
body - cylinder([width / 2.0 - 8.0, rail_t - 1.0, 0], "Y", 3.4, t + 3.0)
