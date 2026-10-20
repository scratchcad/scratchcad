// Upper thread guide plate: 20 x 8 x 1.2 mm steel plate with 3 mm rounded corners, straight 1.2 mm thread slot entering from the side to a 2 mm eye, 3.2 mm screw hole at the other end
let length = 20.0; // [16.0, 30.0] Plate length (mm)
let width = 8.0; // [6.0, 12.0] Plate width (mm)
let thickness = 1.2; // [0.8, 2.0] Plate thickness (mm)
let slot_w = 1.2; // [0.8, 1.6] Thread slot width (mm)
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let plate = plate.fillet(min(3.0, width / 2.0 - 0.5), plate.edges("|Z"));
let ex = length - 5.0;
plate - fuse_all([
    cylinder([ex, 0, -1.0], "Z", 1.0, thickness + 2.0),
    box_from_corners([ex - slot_w / 2.0, 0, -1.0], [ex + slot_w / 2.0, width, thickness + 1.0]),
    cylinder([4.0, 0, -1.0], "Z", 1.6, thickness + 2.0),
])
