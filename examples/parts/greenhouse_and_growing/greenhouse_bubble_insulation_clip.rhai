// Greenhouse insulation clip: twist-lock clip that holds bubble-wrap insulation to an aluminium glazing bar, 30 mm round head 3 mm thick, 6 mm stem 12 mm long ending in a 12 x 6 mm hammer-head that turns 90 degrees in the bar's 6 mm slot
// # Head
let head_d = 30.0; // [20.0, 45.0] Head diameter (mm)
let head_t = 3.0; // [2.0, 5.0] Head thickness (mm)
// # Stem
let stem_length = 12.0; // [6.0, 20.0] Stem length (mm)
let slot_width = 6.0; // [4.0, 10.0] Glazing bar slot width (mm)
let hammer_length = 12.0; // [8.0, 18.0] Hammer-head length (mm)
let head = cylinder(head_d / 2.0, head_t).chamfer(0.8, ">Z");
let grip = box_centered(head_d * 0.7, 3.0, 4.0).translate([0, 0, head_t + 2.0 - 0.01]).fillet(1.0, "|Y");
let stem = cylinder([0, 0, -stem_length], "Z", slot_width / 2.0 - 0.3, stem_length + 0.01);
let hammer = box_centered(hammer_length, slot_width - 0.6, 4.0).translate([0, 0, -stem_length - 2.0 + 0.01]).chamfer(1.0, "<Z");
head + grip + stem + hammer
