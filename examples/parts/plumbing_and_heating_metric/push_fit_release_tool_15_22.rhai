// Push-fit release collar tool for 15 mm and 22 mm fittings (Speedfit/Hep2O style): 110 x 34 x 4 mm plate, fork slots 15.2 and 22.2 mm, 3 mm pusher lips 19.5 and 27 mm OD
let length = 110.0; // [80.0, 150.0] Tool length (mm)
let width = 34.0; // [30.0, 45.0] Tool width (mm)
let thick = 4.0; // [3.0, 6.0] Plate thickness (mm)
let lip = 3.0; // [1.5, 5.0] Pusher lip height (mm)
let small_pipe = 15.0; // [10.0, 16.0] Small pipe size (mm)
let large_pipe = 22.0; // [18.0, 28.0] Large pipe size (mm)
let plate = box_centered(length, width, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(min(width * 0.45, 12.0), plate.edges("|Z"));
let xs = -length / 2.0 + width / 2.0;
let xl = length / 2.0 - width / 2.0;
let rs = small_pipe / 2.0 + 0.1;
let rl = large_pipe / 2.0 + 0.1;
let lip_s = cylinder([xs, 0, thick - 0.5], "Z", min(rs + 2.25, width / 2.0 - 0.5), lip + 0.5);
let lip_l = cylinder([xl, 0, thick - 0.5], "Z", min(rl + 2.5, width / 2.0 - 0.5), lip + 0.5);
let body = plate + lip_s + lip_l;
let cut_s = cylinder([xs, 0, -1], "Z", rs, thick + lip + 2.0) + box_from_corners([-length, -rs, -1], [xs, rs, thick + lip + 1.0]);
let cut_l = cylinder([xl, 0, -1], "Z", rl, thick + lip + 2.0) + box_from_corners([xl, -rl, -1], [length, rl, thick + lip + 1.0]);
body - cut_s - cut_l - cylinder([0, 0, -1], "Z", 3.0, thick + 2.0)
