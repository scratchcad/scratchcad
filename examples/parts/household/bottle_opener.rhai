// Flat bottle opener: 90 x 30 mm, 4 mm thick, 28 mm cap opening with a 3 mm lip tab, key ring hole
let length = 90.0; // [60.0, 140.0] Length (mm)
let width = 30.0; // [20.0, 45.0] Width (mm)
let thickness = 4.0; // [2.0, 6.0] Thickness (mm)
let cap = 28.0; // [26.0, 32.0] Cap opening (mm)
let body = (cylinder([0, 0, 0], "Z", width / 2.0 + 5.0, thickness) + box_from_corners([0, -width / 2.0, 0], [length - width / 2.0, width / 2.0, thickness]) + cylinder([length - width / 2.0, 0, 0], "Z", width / 2.0, thickness));
let opening = cylinder([0, 0, -1], "Z", cap / 2.0, thickness + 2.0) - box_from_corners([cap / 2.0 - 3.0, -4.0, -2], [cap, 4.0, thickness + 2]);
(body - opening - cylinder([length - width / 2.0, 0, -1], "Z", 4.0, thickness + 2.0)).fillet(0.5, ">Z")
