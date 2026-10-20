// Slide rule cursor frame: 40 x 32 mm for a 30 mm rule 8 mm thick, 25 x 26 mm window, side springs
let rule_w = 30.0; // [25.0, 45.0] Rule width (mm)
let rule_t = 8.0; // [5.0, 12.0] Rule thickness (mm)
let length = 40.0; // [30.0, 60.0] Cursor length (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = box_centered(length, rule_w + 2.0 * wall, rule_t + 2.0 * wall);
let inner = box_centered(length + 2.0, rule_w + 0.4, rule_t + 0.4);
let window = box_centered(length - 14.0, rule_w - 4.0, rule_t + 10.0);
outer - inner - window
