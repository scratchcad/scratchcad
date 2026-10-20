// Acorn ground rod clamp for 16 mm rods: 28 mm body 25 mm tall, 17 mm rod bore, 8 mm conductor channel, M10 set screw boss
let rod = 16.0; // [12.0, 20.0] Rod diameter (mm)
let height = 25.0; // [18.0, 35.0] Height (mm)
let body = cylinder(14.0, height) + box_from_corners([-7.0, 0, 0], [7.0, 20.0, height]);
let b = body.fillet(3.0, body.edges("|Z").filter(|e| e.center().y > 19.0));
b - cylinder([0, 0, -1], "Z", rod / 2.0 + 0.5, height + 2.0) - cylinder([-10.0, rod / 2.0 + 2.0, height / 2.0], "X", 4.0, 20.0) - cylinder([0, 10.0, height / 2.0], "Y", 4.25, 15.0)
