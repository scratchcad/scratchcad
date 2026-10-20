// Bar shower mixer S-union concealing shroud: 45 mm OD sleeve 40 mm long, 1.5 mm wall, 65 mm wall flange 3 mm, 24 mm offset bore through the flange for an eccentric union, 2 mm grub screw boss
let sleeve_d = 45.0; // [36.0, 60.0] Sleeve diameter (mm)
let length = 40.0; // [25.0, 70.0] Sleeve length (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let flange_d = 65.0; // [50.0, 85.0] Wall flange diameter (mm)
let offset = 4.0; // [0.0, 8.0] Eccentric offset (mm)
let ro = sleeve_d / 2.0;
let rf = max(flange_d / 2.0, ro + offset + 4.0);
let flange = cylinder(rf, 3.0);
let flange = flange.chamfer(1.2, flange.edges(">Z"));
let sleeve = cylinder([0, 0, 2.0], "Z", ro, length - 2.0);
let body = flange + sleeve;
let bore = cylinder([0, 0, 3.0], "Z", ro - wall, length) + cylinder([offset, 0, -1], "Z", min(12.0, ro - wall - offset - 0.5), 6.0);
let boss = cylinder([0, ro - 1.0, length - 8.0], "Y", 3.0, 3.5);
body + boss - bore - cylinder([0, ro - 3.0, length - 8.0], "Y", 1.0, 8.0)
