// Hand grip strengthener ring: 75 mm OD ring with a 45 mm finger hole, 20 mm wide, faceted 12-sided outer surface for grip
let od = 75.0; // [60.0, 90.0] Ring OD (mm)
let id = 45.0; // [35.0, 55.0] Ring ID (mm)
const w = 20.0;
let pts = [];
for i in 0..12 { let a = (15.0 + 30.0 * i.to_float()) * PI() / 180.0; pts.push([od / 2.0 * cos(a), od / 2.0 * sin(a), 0]); }
face(polygon(pts)).extrude([0, 0, w]) - cylinder([0, 0, -1.0], "Z", id / 2.0, w + 2.0)
