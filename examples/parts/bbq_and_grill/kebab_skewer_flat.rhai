// Flat kebab skewer: 350 mm, 10 x 1.5 mm blade with a 30 mm pointed tip, 25 mm ring handle 4 mm
let length = 350.0; // [250.0, 500.0] Skewer length (mm)
let width = 10.0; // [6.0, 15.0] Blade width (mm)
let t = 1.5; // [1.0, 3.0] Blade thickness (mm)
let blade = polygon([[0, -width / 2.0], [length - 30.0, -width / 2.0], [length, 0], [length - 30.0, width / 2.0], [0, width / 2.0]]).to_face().extrude([0, 0, t]);
let ring = cylinder([-11.0, 0, 0], "Z", 12.5, t) - cylinder([-11.0, 0, -1], "Z", 8.5, t + 2.0);
blade + ring
