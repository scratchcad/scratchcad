// Bunk bed ladder hook: hooks over a 38 mm bed rail, 30 mm wide, 5 mm thick, with a 25 mm hook drop and a 60 mm leg carrying two 6 mm bolt holes for the ladder stile
let rail = 38.0; // [25.0, 50.0] Bed rail thickness (mm)
let width = 30.0; // [20.0, 45.0] Hook width (mm)
const t = 5.0;
let top = box_from_corners([0, 0, 0], [rail + 2.0 * t, width, t]);
let front = box_from_corners([0, 0, -25.0], [t, width, 0.01]);
let back = box_from_corners([rail + t, 0, -60.0], [rail + 2.0 * t, width, 0.01]);
let h = top + front + back;
let h = h.fillet(2.0, h.edges("|Y and >Z"));
h - cylinder([rail, width / 2.0, -25.0], "X", 3.0, 3.0 * t) - cylinder([rail, width / 2.0, -50.0], "X", 3.0, 3.0 * t)
