// Recessed sprinkler escutcheon: 75 mm face plate, 52 mm cup 16 mm deep, 21 mm sprinkler opening, 1 mm wall
let face = 75.0; // [60.0, 90.0] Face diameter (mm)
let cup = 52.0; // [40.0, 60.0] Cup diameter (mm)
let depth = 16.0; // [10.0, 25.0] Cup depth (mm)
let opening = 21.0; // [16.0, 28.0] Sprinkler opening (mm)
let p = sketch("XZ").move_to(opening / 2.0, depth).hline_to(cup / 2.0).vline_to(1.0).hline_to(face / 2.0).vline_to(0).hline_to(cup / 2.0 - 1.0).vline_to(depth - 1.0).hline_to(opening / 2.0).close();
p.face().revolve("Z", 360)
