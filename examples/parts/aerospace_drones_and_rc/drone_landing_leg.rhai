// Drone landing leg: tapered 12 to 6 mm blade 40 mm long, 8 mm thick, 10 mm ball foot, M3 mounting hole and slot
let len = 40.0; // [20.0, 80.0] Leg length (mm)
let leg = polygon([[-6, 0, 0], [6, 0, 0], [3, 0, -len], [-3, 0, -len]]).to_face().extrude([0, 8.0, 0]).translate([0, -4.0, 0]);
leg = leg + sphere([0, 0, -len], 5.0);
leg - cylinder([0, -5, -6.0], "Y", 1.6, 10.0) - box_centered(2.0, 10.0, 6.0).translate([0, 0, -1.0])
