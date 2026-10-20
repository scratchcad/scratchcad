// Pool pole V-clip end: fits a 32 mm pole, 70 mm long, 2 spring buttons 8 mm on 25 mm spacing
let pole = 32.0; // [25.0, 38.0] Pole OD (mm)
let length = 70.0; // [50.0, 100.0] Socket length (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let socket = cylinder(pole / 2.0 + wall, length) - cylinder([0, 0, -1], "Z", pole / 2.0, length - 5.0 + 1.0);
let holes = cylinder([0, -pole, 15.0], "Y", 4.0, pole * 2.0) + cylinder([0, -pole, 40.0], "Y", 4.0, pole * 2.0);
let tongue = box_centered(24.0, 8.0, 30.0).translate([0, 0, length + 14.99]) - cylinder([0, -5, length + 22.0], "Y", 4.0, 10.0);
socket - holes + tongue
