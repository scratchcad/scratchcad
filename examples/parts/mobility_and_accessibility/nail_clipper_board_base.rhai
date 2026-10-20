// One-handed nail clipper board: 140 x 70 x 12 mm base that holds a standard 60 x 14 mm fingernail clipper for palm or elbow operation, 8 mm deep clipper pocket, 40 mm round press pad on a 3 mm hinge-flex web, three 20 mm suction cup holes
// # Board
let length = 140.0; // [110.0, 180.0] Board length (mm)
let width = 70.0; // [55.0, 90.0] Board width (mm)
let thickness = 12.0; // [8.0, 18.0] Board thickness (mm)
// # Clipper
let clipper_l = 60.0; // [50.0, 85.0] Clipper length (mm)
let clipper_w = 14.0; // [10.0, 20.0] Clipper width (mm)
let pad_d = 40.0; // [30.0, 55.0] Press pad diameter (mm)
let board = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]).fillet(10.0, "|Z").fillet(1.5, ">Z");
let pocket = box_centered(clipper_l + 1.0, clipper_w + 1.0, 16.0).translate([-length / 2.0 + clipper_l / 2.0 + 12.0, 0, thickness]).fillet(3.0, "|Z");
let finger_notch = cylinder([-length / 2.0 + 12.0, 0, thickness - 8.0], "Z", 8.0, 10.0);
let pad_x = length / 2.0 - pad_d / 2.0 - 8.0;
let pad = cylinder([pad_x, 0, thickness - 0.01], "Z", pad_d / 2.0, 6.0).chamfer(1.5, ">Z");
let suction = [];
for p in [[-length / 2.0 + 15.0, width / 2.0 - 15.0], [-length / 2.0 + 15.0, -width / 2.0 + 15.0], [length / 2.0 - 15.0, 0.0]] {
    suction.push(cylinder([p[0], p[1], -1.0], "Z", 2.5, 6.0));
    suction.push(cylinder([p[0], p[1], -0.01], "Z", 10.0, 3.0));
}
let web = box_from_corners([-length / 2.0 + clipper_l + 12.0, -3.0, thickness - 0.01], [pad_x, 3.0, thickness + 3.0]);
(board - pocket - finger_notch + pad + web) - fuse_all(suction)
