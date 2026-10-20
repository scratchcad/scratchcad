// Geological compass base plate: 100 x 60 x 4 mm with a 1 mm scale bevel on the long edge, 45 mm capsule recess 2 mm deep, sighting notch and lanyard hole
let length = 100.0; // [80.0, 130.0] Plate length (mm)
let capsule = 45.0; // [35.0, 55.0] Capsule diameter (mm)
const width = 60.0;
const t = 4.0;
let p = box_from_corners([0, 0, 0], [length, width, t]);
let p = p.fillet(5.0, p.edges("|Z"));
let p = p.chamfer(1.0, p.edges("|X and <Y and >Z"));
let rec = cylinder([length * 0.55, width / 2.0, t - 2.0], "Z", capsule / 2.0, 3.0);
let notch = face(polygon([[length - 1.0, width / 2.0 - 3.0, -1.0], [length + 1.0, width / 2.0 - 5.0, -1.0], [length + 1.0, width / 2.0 + 5.0, -1.0], [length - 1.0, width / 2.0 + 3.0, -1.0]])).extrude([0, 0, t + 2.0]);
p - rec - notch - cylinder([8.0, width - 8.0, -1.0], "Z", 2.5, t + 2.0)
