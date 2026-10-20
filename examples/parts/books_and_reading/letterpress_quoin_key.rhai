// Letterpress quoin key: 8 mm square socket 12 mm deep, 70 mm T-bar handle 12 mm, 20 mm hub
let socket = 8.0; // [6.0, 12.0] Square socket (mm)
let handle = 70.0; // [50.0, 100.0] Handle length (mm)
let hub = cylinder(10.0, 25.0);
let bar = cylinder([-handle / 2.0, 0, 30.0], "X", 6.0, handle) + box_centered(12.0, 12.0, 6.0).translate([0, 0, 27.0]);
hub + bar - box_centered(socket + 0.3, socket + 0.3, 24.0)
