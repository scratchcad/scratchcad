// RC boat water-cooling pickup scoop: 20 x 12 mm hull plate 2 mm thick with an 8 mm scoop hood facing forward, 4 mm barb outlet 10 mm tall and a 3 mm pickup hole
let plate_l = 20.0; // [15.0, 30.0] Plate length (mm)
let barb = 4.0; // [4.0, 6.0] Hose barb OD (mm)
const t = 2.0;
let plate = box_from_corners([-plate_l / 2.0, -6.0, 0], [plate_l / 2.0, 6.0, t]);
let hood = box_from_corners([-4.0, -3.0, -4.0], [4.0, 3.0, 0.01]) - box_from_corners([-5.0, -2.0, -3.0], [2.0, 2.0, 0.0]);
let spout = cylinder([0, 0, t - 0.01], "Z", barb / 2.0, 10.0) + cone(barb / 2.0 + 0.5, barb / 2.0, 2.0).translate([0, 0, t + 6.0]);
plate + hood + spout - cylinder([0, 0, -3.5], "Z", 1.5, t + 15.0)
