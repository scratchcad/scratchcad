// Divot repair tool: 55 x 25 x 4 mm body with a 15 mm ball-marker recess 1 mm deep and two tapered 30 mm prongs 4 mm wide with 10 mm between them
let prong = 30.0; // [20.0, 40.0] Prong length (mm)
let gap = 10.0; // [6.0, 14.0] Gap between prongs (mm)
const t = 4.0;
let body = box_from_corners([-12.5, 0, 0], [12.5, 30.0, t]);
let body = body.fillet(8.0, body.edges("|Z and >Y"));
let prongs = [];
for sx in [-1.0, 1.0] {
    let x0 = sx * (gap / 2.0 + 2.0);
    prongs.push(face(polygon([[x0 - 2.0, 0.01, 0], [x0 + 2.0, 0.01, 0], [x0 + 0.6, -prong, 0], [x0 - 0.6, -prong, 0]])).extrude([0, 0, t]));
}
body + fuse_all(prongs) - cylinder([0, 17.0, t - 1.0], "Z", 7.6, 2.0)
