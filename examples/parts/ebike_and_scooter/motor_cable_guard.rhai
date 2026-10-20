// Hub motor axle cable guard: 50 mm disc with a 12 mm flat-sided axle slot (10 mm flats), 8 mm cable channel, 5 mm thick
let diameter = 50.0; // [35.0, 70.0] Guard diameter (mm)
let axle = 12.0; // [10.0, 16.0] Axle diameter (mm)
let flats = 10.0; // [8.0, 14.0] Across flats (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let disc = cylinder(diameter / 2.0, t) + box_from_corners([-6.0, 0, 0], [6.0, diameter / 2.0 + 15.0, t]);
let slot = (cylinder([0, 0, -1], "Z", axle / 2.0, t + 2.0) & box_centered(flats, axle + 2.0, t * 3.0)) + box_from_corners([-flats / 2.0, -diameter, -1], [flats / 2.0, 0, t + 1.0]);
let channel = box_from_corners([-4.0, 0, t - 3.0], [4.0, diameter / 2.0 + 16.0, t + 1.0]);
disc - slot - channel
