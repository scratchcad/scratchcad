// Safety glasses temple hinge: 14 x 7 mm frame plate 2 mm thick with two 3.2 mm knuckles 2 mm long, 1.4 mm pin hole, 2 mm rivet hole
let plate_length = 14.0; // [10.0, 20.0] Plate length (mm)
let plate_width = 7.0; // [5.0, 10.0] Plate width (mm)
let knuckle = 3.2; // [2.5, 4.0] Knuckle diameter (mm)
let pin = 1.4; // [1.0, 2.0] Pin hole diameter (mm)
let plate = box_from_corners([0, -plate_width / 2.0, 0], [plate_length, plate_width / 2.0, 2.0]);
let p = plate.fillet(1.5, plate.edges("|Z and <X"));
let knuckles = [];
for z in [-plate_width / 2.0, plate_width / 2.0 - 2.0] {
    knuckles.push(cylinder([plate_length, z, 0], "Y", knuckle / 2.0, 2.0).translate([0, 0, knuckle / 2.0]));
}
let k = fuse_all(knuckles);
let bridge = box_from_corners([plate_length - 2.0, -plate_width / 2.0, 0], [plate_length, plate_width / 2.0, knuckle]);
let body = p + bridge - box_from_corners([plate_length - 2.5, -plate_width / 2.0 + 2.0, 1.99], [plate_length + 3.0, plate_width / 2.0 - 2.0, knuckle + 1.0]) + k;
body - cylinder([plate_length, -plate_width, knuckle / 2.0], "Y", pin / 2.0, plate_width * 2.0) - cylinder([4.0, 0, -1], "Z", 1.0, 4.0)
