// Top-fix toilet seat hinge block: 40 x 29 x 12 mm base, 16 mm pivot boss with 8.2 mm hinge-rod bore, 8.5 mm hole for the M8 fixing bolt
let length = 40.0; // [30.0, 55.0] Base length (mm)
let base_h = 12.0; // [8.0, 16.0] Base height (mm)
let boss_d = 16.0; // [12.0, 22.0] Pivot boss diameter (mm)
let rod_d = 8.2; // [6.0, 10.0] Hinge rod bore (mm)
let bolt_d = 8.5; // [6.5, 10.5] Fixing bolt hole (mm)
let br = boss_d / 2.0;
let y0 = -bolt_d - 9.0;
let y1 = 3.0 + br;
let base = box_from_corners([-length / 2.0, y0, 0], [length / 2.0, y1, base_h]);
let b = base.fillet(4.0, base.edges("|Z"));
let boss = cylinder([-length / 2.0 + 2.0, 3.0, base_h + br * 0.5], "X", br, length - 4.0);
let part = b + boss;
part - cylinder([-length, 3.0, base_h + br * 0.5], "X", rod_d / 2.0, 2.0 * length) - cylinder([0, y0 + bolt_d / 2.0 + 3.5, -1], "Z", bolt_d / 2.0, base_h + 2.0)
