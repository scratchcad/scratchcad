// Wall-mounted single glove box holder: holds a 230 x 125 x 65 mm box upright, 2 mm walls, open top for loading, 175 x 80 mm front window to pull gloves and two 5 mm screw holes in the back
let box_w = 125.0; // [100.0, 150.0] Glove box width (mm)
let box_h = 230.0; // [200.0, 260.0] Glove box height (mm)
let box_d = 65.0; // [50.0, 90.0] Glove box depth (mm)
const t = 2.0;
let outer = box_from_corners([-box_w / 2.0 - t, -t, 0], [box_w / 2.0 + t, box_d + t, box_h * 0.75]);
let inner = box_from_corners([-box_w / 2.0, 0, t], [box_w / 2.0, box_d, box_h]);
let window = box_from_corners([-box_w / 2.0 + 22.0, box_d - 1.0, 30.0], [box_w / 2.0 - 22.0, box_d + t + 1.0, box_h * 0.75 - 20.0]);
let back = box_from_corners([-box_w / 2.0 - t, -t, 0], [box_w / 2.0 + t, 0, box_h * 0.75 + 30.0]);
let h = outer + back - inner - window;
h - cylinder([-box_w / 4.0, -t - 1.0, box_h * 0.75 + 15.0], "Y", 2.5, t + 2.0) - cylinder([box_w / 4.0, -t - 1.0, box_h * 0.75 + 15.0], "Y", 2.5, t + 2.0)
