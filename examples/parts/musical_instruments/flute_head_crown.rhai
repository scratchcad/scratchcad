// Flute headjoint crown: 22 mm cap, 12 mm tall, M12 x 0.75 style 10 mm stem, decorative groove
let diameter = 22.0; // [18.0, 26.0] Crown diameter (mm)
let height = 12.0; // [8.0, 16.0] Cap height (mm)
let stem = 10.0; // [8.0, 14.0] Stem diameter (mm)
let profile = sketch("XZ").move_to(0, 0).hline_to(diameter / 2.0).vline_to(height - 4.0).arc_to(diameter / 2.0 - 1.5, height - 1.0, diameter / 2.0 - 4.0, height).hline_to(0).close();
let cap = profile.face().revolve("Z", 360);
let groove = cylinder([0, 0, height / 2.0 - 0.5], "Z", diameter, 1.0) - cylinder([0, 0, height / 2.0 - 1.0], "Z", diameter / 2.0 - 0.6, 2.0);
cap - groove + cylinder([0, 0, -6.0], "Z", stem / 2.0, 6.01)
