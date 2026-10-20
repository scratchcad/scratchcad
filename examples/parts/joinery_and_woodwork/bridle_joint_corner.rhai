// Corner bridle joint: 45 x 30 mm rails, one-third tenon 10 mm, open mortise, both parts shown apart 10 mm (two solids)
let width = 45.0; // [25.0, 90.0] Rail width (mm)
let t = 30.0; // [15.0, 45.0] Rail thickness (mm)
let length = 120.0; // [60.0, 250.0] Rail length (mm)
let third = t / 3.0;
let tenon_rail = box_from_corners([0, 0, 0], [length, width, t]) - box_from_corners([-1, -1, -1], [width, width + 1.0, third]) - box_from_corners([-1, -1, 2.0 * third], [width, width + 1.0, t + 1.0]);
let mortise_rail = box_from_corners([0, 0, 0], [width, length, t]) - box_from_corners([-1, -1, third], [width + 1.0, width, 2.0 * third]);
compound([tenon_rail.translate([10.0, 0, 0]), mortise_rail.translate([-width, 0, 0])])
