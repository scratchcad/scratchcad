// Wall clock bezel ring: 200 mm dial window, 230 mm OD, 20 mm deep, 2 mm glass rebate 1.5 mm, rounded front
let window = 200.0; // [150.0, 300.0] Dial window (mm)
let od = 230.0; // [180.0, 350.0] Outside diameter (mm)
let depth = 20.0; // [12.0, 30.0] Depth (mm)
let p = sketch("XZ").move_to(window / 2.0, 0).hline_to(od / 2.0).vline_to(depth - 8.0).arc_to(od / 2.0 - 3.0, depth - 2.0, od / 2.0 - 10.0, depth).hline_to(window / 2.0).close();
let ring = p.face().revolve("Z", 360);
ring - cylinder([0, 0, -1], "Z", window / 2.0 + 2.0, 2.5)
