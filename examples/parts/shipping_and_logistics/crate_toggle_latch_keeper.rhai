// Crate toggle latch keeper: 40 x 25 mm plate 2 mm with a 12 mm hooked catch 3 mm and 4 x 4 mm holes
let length = 40.0; // [30.0, 60.0] Plate length (mm)
let width = 25.0; // [18.0, 35.0] Plate width (mm)
let t = 2.0; // [1.5, 3.0] Plate thickness (mm)
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(3.0, plate.edges("|Z"));
let hook = polygon([[0, 0, t - 0.01], [0, 0, 12.0], [0, 6.0, 12.0], [0, 6.0, 9.0], [0, 3.0, 9.0], [0, 3.0, t - 0.01]]).to_face().extrude([12.0, 0, 0]).translate([-6.0, -6.0, 0]);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (length / 2.0 - 5.0), sy * (width / 2.0 - 5.0), -1], "Z", 2.0, t + 2.0)); } }
p + hook - compound(holes)
