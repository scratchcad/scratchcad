// 1 kg steel telescope counterweight: 70 mm dia, 34 mm thick, 20 mm shaft bore with an M8 thumbscrew hole and 1 mm edge chamfers
let od = 70.0; // [55.0, 90.0] Outside diameter (mm)
let thick = 34.0; // [20.0, 50.0] Thickness (mm)
let shaft = 20.0; // [12.0, 25.0] Counterweight shaft diameter (mm)
let w = cylinder([0, 0, 0], "Z", od / 2.0, thick);
let w = w.chamfer(1.0, w.edges("%CIRCLE"));
let bore = cylinder([0, 0, -1.0], "Z", shaft / 2.0 + 0.3, thick + 2.0);
let screw = cylinder([0, 0, thick / 2.0], "X", 3.4, od / 2.0 + 1.0);
w - bore - screw
