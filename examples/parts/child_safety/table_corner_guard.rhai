// Table corner guard: 40 x 40 mm corner cap for a 25 mm table top, 3 mm walls, 15 mm deep sleeves with a soft 8 mm radiused outer corner, open on the inner faces
let top = 25.0; // [15.0, 40.0] Table top thickness (mm)
let leg = 40.0; // [30.0, 60.0] Guard leg length (mm)
const wall = 3.0;
let o = box_from_corners([-wall, -wall, -wall], [leg, leg, top + wall]);
let o = o.fillet(8.0, o.edges("|Z and <X and <Y"));
let inner = box_from_corners([0, 0, 0], [leg + 1.0, leg + 1.0, top]);
o - inner - box_from_corners([15.0, 15.0, -wall - 1.0], [leg + 1.0, leg + 1.0, 0.01]) - box_from_corners([15.0, 15.0, top - 0.01], [leg + 1.0, leg + 1.0, top + wall + 1.0])
