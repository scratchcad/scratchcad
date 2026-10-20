// Fountain bell nozzle: 1/2 inch (21 mm) inlet spigot 20 mm, conical body to a 40 mm deflector disc with a 2 mm annular water gap, and a 6 mm centre stem
let deflector = 40.0; // [25.0, 60.0] Deflector disc diameter (mm)
let gap = 2.0; // [1.0, 4.0] Water gap (mm)
const inlet = 21.0;
let spig = cylinder([0, 0, 0], "Z", inlet / 2.0, 20.01) - cylinder([0, 0, -1.0], "Z", inlet / 2.0 - 2.5, 22.0);
let cone_body = cone(inlet / 2.0, 14.0, 15.0).translate([0, 0, 20.0]) - cone(inlet / 2.0 - 2.5, 12.0, 15.02).translate([0, 0, 19.99]);
let stem = cylinder([0, 0, 20.0], "Z", 3.0, 15.0 + gap + 0.01);
let spider = box_centered(inlet - 5.0, 2.0, 3.0).translate([0, 0, 21.5]) + box_centered(2.0, inlet - 5.0, 3.0).translate([0, 0, 21.5]);
let disc = cylinder([0, 0, 35.0 + gap], "Z", deflector / 2.0, 2.0);
spig + cone_body + stem + spider + disc
