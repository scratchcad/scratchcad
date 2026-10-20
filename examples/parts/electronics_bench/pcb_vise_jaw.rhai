// PCB holder vise jaw: 80 x 20 x 15 mm with a 1.8 mm V-groove for boards, 2 M4 tapped holes 50 mm apart
let length = 80.0; // [50.0, 150.0] Jaw length (mm)
let height = 20.0; // [12.0, 30.0] Jaw height (mm)
let depth = 15.0; // [10.0, 25.0] Jaw depth (mm)
let groove = 1.8; // [1.0, 3.2] Board thickness slot (mm)
let jaw = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, height]);
let v = polygon([[0, -0.01, height * 0.6 - groove * 1.5], [0, 3.0, height * 0.6 - groove / 2.0], [0, 3.0, height * 0.6 + groove / 2.0], [0, -0.01, height * 0.6 + groove * 1.5]]).to_face().extrude([length + 2.0, 0, 0]).translate([-length / 2.0 - 1.0, 0, 0]);
jaw - v - cylinder([-25.0, depth / 2.0, -1], "Z", 1.65, 12.0) - cylinder([25.0, depth / 2.0, -1], "Z", 1.65, 12.0)
