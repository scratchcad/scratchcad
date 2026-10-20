// Kart rear bumper tube socket: 31 mm OD sleeve 40 mm long taking a 25.4 mm bumper tube, M6 cross-pin hole (6.4 mm) 15 mm from the open end, welded to a 60 x 40 x 5 mm base plate with two M8 clearance holes (8.5 mm) 40 mm apart and 4 mm rounded corners
let tube_d = 25.4; // [19.0, 30.0] Bumper tube diameter (mm)
let socket_len = 40.0; // [25.0, 70.0] Socket length (mm)
let plate_len = 60.0; // [55.0, 90.0] Base plate length (mm)
const plate_t = 5.0;
const plate_w = 40.0;
let ri = tube_d / 2.0 + 0.2;
let ro = ri + 3.0;
let pl = max(plate_len, 2.0 * ro + 26.0);
let plate = box_centered(pl, max(plate_w, 2.0 * ro + 4.0), plate_t).translate([0, 0, plate_t / 2.0]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let sleeve = cylinder([0, 0, plate_t - 0.5], "Z", ro, socket_len + 0.5);
let body = plate + sleeve;
let sp = pl / 2.0 - 7.0;
let cuts = [
    cylinder([0, 0, plate_t], "Z", ri, socket_len + 1.0),
    cylinder([-ro - 1.0, 0, plate_t + socket_len - 15.0], "X", 3.2, 2.0 * ro + 2.0),
    cylinder([-sp, 0, -1.0], "Z", 4.25, plate_t + 2.0),
    cylinder([sp, 0, -1.0], "Z", 4.25, plate_t + 2.0)
];
body - fuse_all(cuts)
