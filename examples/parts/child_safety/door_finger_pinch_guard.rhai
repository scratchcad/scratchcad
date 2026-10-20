// Door finger pinch guard: C-shaped stop 120 mm tall that clips over a 45 mm door edge, 10 mm thick body with 30 mm deep arms ending in 10 mm rounded grip beads
let door = 45.0; // [30.0, 55.0] Door thickness (mm)
let height = 120.0; // [80.0, 160.0] Guard height (mm)
const t = 10.0;
let c = box_from_corners([0, 0, 0], [door + 2.0 * t, t, height]) + box_from_corners([0, 0, 0], [t, 30.0, height]) + box_from_corners([door + t, 0, 0], [door + 2.0 * t, 30.0, height]);
let ends = cylinder([t / 2.0, 30.0, 0], "Z", t / 2.0, height) + cylinder([door + 1.5 * t, 30.0, 0], "Z", t / 2.0, height);
c + ends
