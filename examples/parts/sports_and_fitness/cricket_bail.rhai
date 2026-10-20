// Senior cricket bail (Laws of Cricket): 109.5 mm overall, 54 mm barrel up to 14 mm diameter, 35 mm long spigot and 20.5 mm short spigot, turned beads at the barrel ends
let length = 109.5; // [90.0, 120.0] Overall length (mm)
let barrel = 54.0; // [40.0, 65.0] Barrel length (mm)
let barrel_d = 14.0; // [10.0, 18.0] Barrel diameter (mm)
let long_spigot = 35.0; // [25.0, 40.0] Long spigot length (mm)
let spigot_d = 8.0; // [6.0, 10.0] Spigot diameter (mm)
let short_spigot = length - barrel - long_spigot;
let rb = barrel_d / 2.0;
let rs = spigot_d / 2.0;
const x0 = 0.0;
let x1 = short_spigot;
let x2 = x1 + barrel;
let x3 = length;
let prof = sketch("XY").move_to(x0, 0).vline_to(rs - 1.5).arc_to(x0 + 0.44, rs - 0.44, x0 + 1.5, rs).hline_to(x1 - 3.0)
    .arc_to(x1 - 2.2, rb - 1.2, x1, rb).arc_to(x1 + 3.0, rb - 2.5, x1 + 6.0, rb - 2.0)
    .arc_to((x1 + x2) / 2.0, rb - 0.6, x2 - 6.0, rb - 2.0).arc_to(x2 - 3.0, rb - 2.5, x2, rb).arc_to(x2 + 2.2, rb - 1.2, x2 + 3.0, rs)
    .hline_to(x3 - 1.5).arc_to(x3 - 0.44, rs - 0.44, x3, rs - 1.5).vline_to(0).close();
prof.to_face().revolve("X", 360)
