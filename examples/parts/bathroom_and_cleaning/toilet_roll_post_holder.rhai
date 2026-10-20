// Single-post toilet roll holder: 60 x 80 x 5 mm wall plate, 28 mm post 145 mm long for 40 mm roll cores, 36 mm end stop, 2 x 4.5 mm screw holes
let post_d = 28.0; // [22.0, 36.0] Post diameter (mm)
let post_l = 145.0; // [110.0, 180.0] Post length (mm)
let stop_d = 36.0; // [30.0, 45.0] End stop diameter (mm)
let plate_w = 60.0; // [45.0, 80.0] Plate width (mm)
let plate_h = 80.0; // [60.0, 110.0] Plate height (mm)
let plate = box_from_corners([-plate_w / 2.0, 0, -plate_h / 2.0], [plate_w / 2.0, 5.0, plate_h / 2.0]);
let p = plate.fillet(6.0, plate.edges("|Y"));
let post = cylinder([0, 4.0, 0], "Y", post_d / 2.0, post_l - 4.0);
let stop = cylinder([0, post_l - 1.0, 0], "Y", stop_d / 2.0, 6.0);
let s = stop.fillet(2.0, stop.edges(">Y"));
let screws = [cylinder([0, -1, plate_h / 2.0 - 10.0], "Y", 2.25, 7.0), cylinder([0, -1, -plate_h / 2.0 + 10.0], "Y", 2.25, 7.0)];
p + post + s - compound(screws)
