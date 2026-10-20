// Syringe dose stop clip for 5 ml oral syringe plungers: C clip 20 mm long (the dose length) with a 9.6 mm bore over the 9 mm cross-ribbed rod, 2 mm wall and a 7 mm snap opening, with a 2 mm web 8 mm long opposite the opening ending in a 6 mm wide finger bar up to 12 mm tall
let dose_len = 20.0; // [5.0, 50.0] Clip length (mm)
let rod_d = 9.6; // [7.0, 12.0] Rod bore (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let opening = 7.0; // [5.0, 9.0] Snap opening (mm)
const tab_len = 8.0;
let ri = rod_d / 2.0;
let ro = ri + wall;
let gap = min(opening, rod_d - 1.5);
let tab_w = min(12.0, dose_len);
let body = cylinder(ro, dose_len) + box_from_corners([-tab_len - ro, -1.0, 0], [-ro + 0.5, 1.0, dose_len]);
let body = body + box_from_corners([-tab_len - ro, -3.0, (dose_len - tab_w) / 2.0], [-tab_len - ro + 2.0, 3.0, (dose_len + tab_w) / 2.0]);
body - cylinder([0, 0, -1.0], "Z", ri, dose_len + 2.0) - box_from_corners([0, -gap / 2.0, -1.0], [ro + 1.0, gap / 2.0, dose_len + 1.0])
