// Cup holder phone dock: 64 to 70 mm tapered base 55 mm tall that wedges in a car cup holder, 80 mm wide cradle with a 13 mm phone slot, backrest leaning 15 degrees, 12 x 8 mm USB-C cable pass-through
let base_bottom = 64.0; // [55.0, 75.0] Base bottom diameter (mm)
let base_top = 70.0; // [60.0, 85.0] Base top diameter (mm)
let base_h = 55.0; // [35.0, 75.0] Base height (mm)
let cradle_w = 80.0; // [60.0, 100.0] Cradle width (mm)
let phone_t = 13.0; // [8.0, 18.0] Phone slot (mm)
let lean = 15.0; // [5.0, 30.0] Backrest lean (degrees)

const plate_t = 6.0;
const back_h = 70.0;
const back_t = 5.0;
const lip_h = 12.0;
let base = cone(base_bottom / 2.0, base_top / 2.0, base_h);
base = base - cone(base_bottom / 2.0 - 3.0, base_top / 2.0 - 3.0, base_h - 4.0).translate([0, 0, -0.01 - 1.0]);
let plate = box_centered(cradle_w, phone_t + back_t + 10.0, plate_t).translate([0, 0, base_h + plate_t / 2.0 - 0.5]);
plate = plate.fillet(4.0, plate.edges("|Z"));
let y_back = phone_t / 2.0;
let back = box_from_corners([-cradle_w / 2.0, 0, 0], [cradle_w / 2.0, back_t, back_h]).rotate_x(-lean).translate([0, y_back, base_h + plate_t - 2.0]);
back = back & box_from_corners([-cradle_w, -50.0, base_h], [cradle_w, 80.0, base_h + back_h + 10.0]);
let lip = box_from_corners([-cradle_w / 2.0, -phone_t / 2.0 - 4.0, base_h], [cradle_w / 2.0, -phone_t / 2.0, base_h + plate_t + lip_h]);
lip = lip.fillet(1.9, lip.edges(">Z"));
let dock = fuse_all([base, plate, back, lip]);
let cable = box_centered(12.0, 8.0, 60.0).translate([0, 0, base_h]);
dock = dock - cable.fillet(3.9, cable.edges("|Z"));
dock - box_centered(22.0, 6.0, lip_h + 2.0).translate([0, -phone_t / 2.0 - 2.0, base_h + plate_t + lip_h / 2.0 + 2.0])
