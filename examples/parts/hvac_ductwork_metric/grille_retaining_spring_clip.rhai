// Ceiling grille retaining spring clip: 10 mm wide strip 1.2 mm thick, 18 mm screw tab with a 4 mm hole, 25 mm vertical leg, 22 mm spring leg sloping out at 25 degrees with a 4 mm turned-in tip
let width = 10.0; // [6.0, 16.0] Strip width (mm)
let t = 1.2; // [0.8, 2.0] Strip thickness (mm)
let leg = 25.0; // [15.0, 40.0] Vertical leg (mm)
let spring = 22.0; // [12.0, 35.0] Spring leg length (mm)
let flare = 25.0; // [10.0, 40.0] Spring leg angle (degrees)
const tab = 18.0;
let a = flare * PI() / 180.0;
let tab_plate = box_from_corners([-tab, 0, 0], [t, width, t]);
let vert = box_from_corners([0, 0, 0], [t, width, leg]);
// spring leg hinges at the top of the vertical leg and slopes outward and down
let sp = box_from_corners([0, 0, leg - spring], [t, width, leg + t * 0.5]).rotate([t, 0, leg], "Y", -flare);
let sp_end_x = t + spring * a.sin();
let sp_end_z = leg - spring * a.cos();
let tip = box_from_corners([sp_end_x - 4.0, 0, sp_end_z - t * 0.5], [sp_end_x + t * 0.5, width, sp_end_z + t * 0.5]);
let clip = fuse_all([tab_plate, vert, sp, tip]);
clip - cylinder([-tab / 2.0, width / 2.0, -1], "Z", 2.0, t + 2.0)
