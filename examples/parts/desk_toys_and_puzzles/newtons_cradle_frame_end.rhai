// Newton's cradle frame end: 120 mm tall A-frame end 8 mm thick with a 6 mm top rod hole, a 6 mm lower crossbar hole and two feet 80 mm long, open centre
let height = 120.0; // [80.0, 160.0] Frame height (mm)
let foot = 80.0; // [50.0, 120.0] Foot length (mm)
const t = 8.0;
let outer = face(polygon([[-50.0, 0, 0], [50.0, 0, 0], [12.0, 0, height], [-12.0, 0, height]])).extrude([0, t, 0]);
let inner = face(polygon([[-35.0, -1.0, 16.0], [35.0, -1.0, 16.0], [6.0, -1.0, height - 20.0], [-6.0, -1.0, height - 20.0]])).extrude([0, t + 2.0, 0]);
let feet = box_from_corners([-50.0, t / 2.0 - foot / 2.0, 0], [-40.0, t / 2.0 + foot / 2.0, 6.0]) + box_from_corners([40.0, t / 2.0 - foot / 2.0, 0], [50.0, t / 2.0 + foot / 2.0, 6.0]);
outer - inner + feet - cylinder([0, -1.0, height - 8.0], "Y", 3.0, t + 2.0) - cylinder([0, -1.0, 9.0], "Y", 3.0, t + 2.0)
