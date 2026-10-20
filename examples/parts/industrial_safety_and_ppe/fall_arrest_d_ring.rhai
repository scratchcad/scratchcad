// Fall arrest harness D-ring: 75 x 55 mm forged D, 10 mm square section, 55 mm webbing bar opening, 1 mm edge chamfer
let width = 75.0; // [60.0, 100.0] D-ring width (mm)
let height = 55.0; // [45.0, 75.0] D-ring height (mm)
let section = 10.0; // [8.0, 14.0] Bar section (mm)
let r_out = width / 2.0;
// keep the straight sides at least 4 mm longer than the bar section
let straight = (height - r_out).max(section + 4.0);
// D outline: straight webbing bar along X with a rounded bow
let outer = sketch("XY").move_to(-r_out, 0).hline_to(r_out).vline_to(straight).arc_to(0, straight + r_out, -r_out, straight).close();
let ri = r_out - section;
let inner = sketch("XY").move_to(-ri, section).hline_to(ri).vline_to(straight).arc_to(0, straight + r_out - section, -ri, straight).close();
let d = face(outer, [inner]).extrude([0, 0, section]);
d.chamfer(1.0)
