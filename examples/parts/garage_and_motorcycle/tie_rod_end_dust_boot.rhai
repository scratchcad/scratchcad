// Tie rod end ball joint dust boot: 30 mm base bead for a 22 mm socket, 22 mm tall bellied rubber body 2 mm thick, 12 mm stud neck
let base_d = 30.0; // [22.0, 40.0] Base bead diameter (mm)
let base_id = 22.0; // [16.0, 32.0] Base opening (mm)
let height = 22.0; // [15.0, 32.0] Height (mm)
let neck_id = 12.0; // [8.0, 18.0] Stud neck opening (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let rb = base_d / 2.0;
let rbi = min(base_id, base_d - 4.0) / 2.0;
let rn = neck_id / 2.0;
let neck_o = rn + wall;
let outer = sketch("XZ").move_to(0, 0).hline_to(rb).vline_to(4.0).arc_to(rb + 1.0, height * 0.5, neck_o, height - 4.0).vline_to(height).hline_to(0).close();
let inner = sketch("XZ").move_to(0, -1.0).hline_to(rbi).vline_to(4.0).hline_to(rb - wall).arc_to(rb + 1.0 - wall, height * 0.5, rn, height - 4.0 - wall).vline_to(height + 1.0).hline_to(0).close();
outer.to_face().revolve("Z", 360) - inner.to_face().revolve("Z", 360)
