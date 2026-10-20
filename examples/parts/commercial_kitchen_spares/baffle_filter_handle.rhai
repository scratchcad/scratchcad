// Kitchen hood grease baffle filter handle: 2 mm stainless strip 15 mm wide bent into a 100 mm U-handle standing 30 mm proud, with 20 mm feet and 3.2 mm rivet holes
let span = 100.0; // [70.0, 150.0] Handle span between legs (mm)
let rise = 30.0; // [20.0, 45.0] Handle rise (mm)
let width = 15.0; // [10.0, 25.0] Strip width (mm)
const t = 2.0;
const foot = 20.0;
let a = span / 2.0;
let pts = [[-a - foot, 0, 0], [-a + t, 0, 0], [-a + t, 0, rise - t], [a - t, 0, rise - t], [a - t, 0, 0], [a + foot, 0, 0], [a + foot, 0, t], [a, 0, t], [a, 0, rise], [-a, 0, rise], [-a, 0, t], [-a - foot, 0, t]];
let h = face(polygon(pts)).extrude([0, width, 0]);
let holes = [];
for sx in [-1.0, 1.0] { holes.push(cylinder([sx * (a + foot / 2.0), width / 2.0, -1.0], "Z", 1.6, t + 2.0)); }
h - compound(holes)
