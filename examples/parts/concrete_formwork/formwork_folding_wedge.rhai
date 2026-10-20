// Formwork folding wedge: 150 x 40 mm hardwood-style wedge from 25 mm to 3 mm thick with a 10 mm hammer face at the thick end and a 6 mm nail hole
let length = 150.0; // [100.0, 220.0] Wedge length (mm)
let thick = 25.0; // [15.0, 40.0] Thick end (mm)
const w = 40.0;
let wd = face(polygon([[0, 0, 0], [length, 0, 0], [length, 0, 3.0], [10.0, 0, thick], [0, 0, thick]])).extrude([0, w, 0]);
wd - cylinder([length * 0.4, w / 2.0, -1.0], "Z", 3.0, thick + 2.0)
