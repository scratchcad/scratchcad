// Castanet half shell: 55 mm across, 20 mm thick dome with a 45 mm hollow, two 4 mm cord holes and ear
let diameter = 55.0; // [40.0, 70.0] Diameter (mm)
let height = 20.0; // [12.0, 28.0] Dome height (mm)
let wall = 4.0; // [2.5, 6.0] Wall (mm)
let rs = (diameter * diameter / 4.0 + height * height) / (2.0 * height);
let dome = sphere([0, 0, height - rs], rs) & cylinder(diameter / 2.0, height);
let hollow = sphere([0, 0, height - rs - wall], rs) & cylinder([0, 0, -1], "Z", diameter / 2.0 - wall, height);
let ear = box_from_corners([-8.0, diameter / 2.0 - 4.0, 0], [8.0, diameter / 2.0 + 8.0, 8.0]);
let e = ear.fillet(3.0, ear.edges("|Z and >Y"));
dome - hollow + e - cylinder([-4.0, diameter / 2.0 + 3.0, -1], "Z", 2.0, 10.0) - cylinder([4.0, diameter / 2.0 + 3.0, -1], "Z", 2.0, 10.0)
