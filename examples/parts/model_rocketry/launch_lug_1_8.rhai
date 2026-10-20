// 1/8 in launch lug: 3.6 mm ID, 4.6 mm OD, 40 mm long, faired 30 degree standoff 2 mm tall
let id = 3.6; // [3.2, 6.6] Inside diameter (mm)
let od = 4.6; // [4.0, 8.0] Outside diameter (mm)
let length = 40.0; // [20.0, 80.0] Length (mm)
let fair = polygon([[0, -3.0, 0], [0, length + 3.0, 0], [0, length, od / 2.0 + 2.0], [0, 0, od / 2.0 + 2.0]]).to_face().extrude([1.6, 0, 0]).translate([-0.8, 0, 0]);
let lp = cylinder([0, 0, 0], "Y", od / 2.0, length).translate([0, 0, od / 2.0 + 2.0]);
(lp + fair) - cylinder([0, -1, od / 2.0 + 2.0], "Y", id / 2.0, length + 2.0)
