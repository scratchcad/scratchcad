// Volume damper lever handle for a 12 mm square spindle: 100 mm arm 18 mm wide 4 mm thick, 28 mm boss 14 mm tall with a 12.2 mm square socket, 6.5 mm locking stud hole 40 mm out, pointed indicator tip
let spindle = 12.2; // [8.0, 14.0] Square socket size (mm)
let arm_l = 100.0; // [60.0, 150.0] Arm length (mm)
let arm_w = 18.0; // [14.0, 28.0] Arm width (mm)
let t = 4.0; // [3.0, 6.0] Arm thickness (mm)
let boss_h = 14.0; // [8.0, 20.0] Boss height (mm)
let boss_r = max(14.0, spindle * 0.75 + 4.0);
let arm = polygon([[0, -arm_w / 2.0, 0], [arm_l - arm_w / 2.0, -arm_w / 2.0, 0], [arm_l, 0, 0], [arm_l - arm_w / 2.0, arm_w / 2.0, 0], [0, arm_w / 2.0, 0]]).to_face().extrude([0, 0, t]);
let boss = cylinder(boss_r, boss_h);
let handle = arm.fillet(1.0, arm.edges("|Z").filter(|e| e.center().x > 1.0)) + boss;
let socket = box_centered(spindle, spindle, boss_h + 2.0).translate([0, 0, boss_h / 2.0]);
let stud = cylinder([min(40.0, arm_l * 0.5), 0, -1], "Z", 3.25, t + 2.0);
let grip = box_centered(arm_l * 0.3, 2.0, 1.0).translate([arm_l * 0.75, 0, t]);
handle - socket - stud - grip
