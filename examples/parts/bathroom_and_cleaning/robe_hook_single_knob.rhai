// Single robe hook: 44 mm wall rosette 10 mm, 12 mm arm 55 mm long angled up 20 degrees, 18 mm ball knob, 2 x 4 mm screw holes
let rosette_d = 44.0; // [34.0, 60.0] Rosette diameter (mm)
let arm_l = 55.0; // [35.0, 80.0] Arm length (mm)
let arm_d = 12.0; // [8.0, 16.0] Arm diameter (mm)
let angle = 20.0; // [0.0, 45.0] Arm angle (degrees)
let knob_d = 18.0; // [12.0, 26.0] Knob diameter (mm)
let rosette = cylinder([0, 0, 0], "Y", rosette_d / 2.0, 10.0);
let ro = rosette.fillet(2.0, rosette.edges(">Y"));
let arm = cylinder([0, 5.0, 0], "Y", arm_d / 2.0, arm_l).rotate([0, 5.0, 0], "X", angle);
let a = angle * PI() / 180.0;
let tip = [0, 5.0 + arm_l * a.cos(), arm_l * a.sin()];
let knob = sphere(tip, knob_d / 2.0);
let screws = [cylinder([0, -1, rosette_d * 0.3], "Y", 2.0, 12.0), cylinder([0, -1, -rosette_d * 0.3], "Y", 2.0, 12.0)];
ro + arm + knob - compound(screws)
