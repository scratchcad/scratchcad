// Outboard hydrofoil stabiliser fin for the cavitation plate: 5 mm plate 330 mm wide and 150 mm long with swept 20 degree tips, a 70 mm wide 100 mm deep notch for the gearcase, 10 mm downturned edges on the wing tips, and four 7 mm bolt holes in pairs 40 mm apart either side of the notch
let span = 330.0; // [250.0, 420.0] Wing span (mm)
let chord = 150.0; // [110.0, 200.0] Wing chord (mm)
let notch_w = 70.0; // [50.0, 90.0] Gearcase notch width (mm)
const t = 5.0;
let s = span / 2.0;
let sweep = chord * 0.6 * tan(20.0 * PI() / 180.0);
let plate = face(polygon([[0, -notch_w / 2.0, 0], [0, -s + sweep, 0], [chord * 0.6, -s, 0], [chord, -s, 0], [chord, s, 0], [chord * 0.6, s, 0], [0, s - sweep, 0], [0, notch_w / 2.0, 0],
    [chord * 0.67, notch_w / 2.0, 0], [chord * 0.67, -notch_w / 2.0, 0]])).extrude([0, 0, t]);
let tips = [];
for k in [-1.0, 1.0] {
    tips.push(box_from_corners([chord * 0.6, k * s - 4.0, -10.0], [chord, k * s + 4.0, 0.5]) & box_from_corners([0, -s, -11.0], [chord + 1.0, s, 1.0]));
}
let body = plate + fuse_all(tips);
let cuts = [];
for k in [-1.0, 1.0] {
    for x in [chord * 0.25, chord * 0.25 + 40.0] {
        cuts.push(cylinder([x, k * (notch_w / 2.0 + 15.0), -1.0], "Z", 3.5, t + 2.0));
    }
}
body - fuse_all(cuts)
