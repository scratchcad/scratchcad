// Hand sanitiser bottle holder for a 25 x 10 mm medical equipment rail: 72 mm cup for a 500 ml pump bottle, 2.5 mm wall, 40 mm tall with a 50 mm base opening, and a back hook that drops over the 10 mm rail
let bottle_d = 72.0; // [55.0, 90.0] Bottle diameter (mm)
let height = 40.0; // [25.0, 60.0] Cup height (mm)
let rail_t = 10.0; // [8.0, 12.0] Rail thickness (mm)
const wall = 2.5;
const rail_h = 25.0;
let ri = bottle_d / 2.0 + 1.0;
let ro = ri + wall;
let cup = face(polygon([[ri - 10.0, 0, 0], [ro, 0, 0], [ro, 0, height], [ri, 0, height], [ri, 0, wall], [ri - 10.0, 0, wall]])).revolve("Z", 360);
let back = box_from_corners([-25.0, -ro - 4.0, 0], [25.0, -ri, height + rail_h + 4.0]);
let hook = box_from_corners([-25.0, -ro - 4.0 - rail_t - 4.0, height + rail_h], [25.0, -ro - 3.99, height + rail_h + 4.0]) + box_from_corners([-25.0, -ro - 4.0 - rail_t - 4.0, height + rail_h - 15.0], [25.0, -ro - 4.0 - rail_t, height + rail_h + 4.0]);
cup + back + hook - cylinder([0, 0, wall], "Z", ri, height + 1.0)
