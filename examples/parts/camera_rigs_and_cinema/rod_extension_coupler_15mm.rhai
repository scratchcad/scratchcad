// Rod extension coupler for 15 mm rods: 15 mm OD, 40 mm long sleeve with M12 x 1.75 tapped bores (10.2 mm core) 18 mm deep from each end, 13 mm spanner flats 8 mm long in the middle and 1 mm end chamfers
let rod_d = 15.0; // [12.0, 19.0] Rod diameter (mm)
let length = 40.0; // [30.0, 60.0] Coupler length (mm)
let thread_d = 12.0; // [8.0, 12.0] Thread size (mm)
let r = rod_d / 2.0;
let body = face(polygon([[0, 0, 0], [r - 1.0, 0, 0], [r, 0, 1.0], [r, 0, length - 1.0], [r - 1.0, 0, length], [0, 0, length]])).revolve("Z", 360.0);
let flats = box_centered(rod_d + 2.0, rod_d + 2.0, 8.0).translate([0, 0, length / 2.0]) - box_centered(rod_d + 4.0, rod_d - 2.0, 10.0).translate([0, 0, length / 2.0]);
let depth = length / 2.0 - 2.0;
let core = thread_d * 0.85 / 2.0;
body - flats - cylinder([0, 0, -1.0], "Z", core, depth + 1.0) - cylinder([0, 0, length - depth], "Z", core, depth + 1.0)
