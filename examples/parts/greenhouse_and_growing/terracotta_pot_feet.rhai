// Pot feet: set-of-one riser foot that lifts a plant pot 20 mm for drainage, 40 x 30 mm wedge-top foot with a 5 degree inward slope, 8 mm lip that tucks under the pot rim, hollow underside with 2.5 mm walls
// # Foot
let length = 40.0; // [30.0, 60.0] Foot length (mm)
let width = 30.0; // [20.0, 45.0] Foot width (mm)
let height = 20.0; // [12.0, 35.0] Foot height (mm)
// # Detail
let slope = 5.0; // [0.0, 10.0] Top slope (degrees)
let lip = 8.0; // [4.0, 12.0] Lip height (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
let drop = length * (slope * PI() / 180.0).tan();
let body = polygon("XZ", [[0.0, 0.0], [length, 0.0], [length, height], [0.0, height - drop]]).to_face().extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let lip_block = box_from_corners([length - 4.0, -width / 2.0 + 3.0, height - 0.01], [length, width / 2.0 - 3.0, height + lip]).fillet(1.0, ">Z");
let shaped = body.fillet(2.0, "|Z") + lip_block;
let hollow = box_from_corners([wall, -width / 2.0 + wall, -1.0], [length - wall, width / 2.0 - wall, height - drop - wall]);
shaped - hollow
