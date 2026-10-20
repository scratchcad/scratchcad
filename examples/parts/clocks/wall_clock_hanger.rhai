// Wall clock keyhole hanger: 30 x 15 x 4 mm plate, 8 mm keyhole for a 4 mm screw head, 2 x 2 mm tack holes
let length = 30.0; // [20.0, 45.0] Length (mm)
let width = 15.0; // [10.0, 20.0] Width (mm)
let t = 4.0; // [2.5, 6.0] Thickness (mm)
let plate = box_centered(width, length, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(3.0, plate.edges("|Z"));
let key = cylinder([0, -4.0, -1], "Z", 4.0, t + 2.0) + box_from_corners([-2.0, -4.0, -1], [2.0, 6.0, t + 1.0]);
let pocket = box_from_corners([-4.5, -8.5, -1], [4.5, 8.0, t - 1.2]);
p - key - pocket.fillet(1.0, pocket.edges("|Z")) - cylinder([0, length / 2.0 - 3.0, -1], "Z", 1.0, t + 2.0) - cylinder([0, -length / 2.0 + 2.5, -1], "Z", 1.0, t + 2.0)
