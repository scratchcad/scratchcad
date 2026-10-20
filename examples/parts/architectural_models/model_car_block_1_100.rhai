// 1:100 massing car: 45 x 18 mm block 10 mm tall (4.5 x 1.8 x 1.5 m car), with a 25 mm cabin 5 mm tall set back and 1 mm chamfered edges
let length = 45.0; // [35.0, 60.0] Car length (mm)
let width = 18.0; // [15.0, 22.0] Car width (mm)
let body = box_centered(length, width, 7.0).translate([0, 0, 3.5]);
let body = body.chamfer(1.0, body.edges(">Z"));
let cabin = box_centered(length * 0.55, width - 2.0, 5.0).translate([-length * 0.05, 0, 7.0 + 2.5 - 0.01]);
let cabin = cabin.chamfer(1.0, cabin.edges(">Z"));
body + cabin
