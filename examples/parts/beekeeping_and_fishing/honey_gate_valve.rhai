// Honey bucket gate valve body: 1.5 in (48 mm) thread boss 20 mm, 30 mm bore, slide gate slot 70 x 6 mm
let boss_d = 48.0; // [40.0, 60.0] Thread boss diameter (mm)
let bore = 30.0; // [20.0, 40.0] Bore (mm)
let body = cylinder(boss_d / 2.0, 20.0) + box_centered(70.0, 50.0, 30.0).translate([0, 0, 34.99]);
let b = body - cylinder([0, 0, -1], "Z", bore / 2.0, 20.0) - box_centered(80.0, bore + 6.0, 6.0).translate([10.0, 0, 30.0]);
let spout = box_centered(bore + 10.0, 20.0, 15.0).translate([0, -25.0 - 9.99, 45.0]) - box_centered(bore, 22.0, 10.0).translate([0, -25.0 - 10.0, 42.0]);
let channel = box_centered(bore, bore, 20.0).translate([0, 0, 40.0]) + box_centered(bore, 30.0, 10.0).translate([0, -20.0, 42.0]);
b + spout - channel
