// Tile spacer cross, 3 mm joint: four 10 mm arms 3 mm wide and 6 mm tall with chamfered tips
let joint = 3.0; // [1.8, 10.0] Joint width (mm)
let arm = 10.0; // [6.0, 20.0] Arm length (mm)
let x = box_centered(2.0 * arm, joint, 6.0) + box_centered(joint, 2.0 * arm, 6.0);
x.chamfer(0.5, ">X or <X or >Y or <Y")
