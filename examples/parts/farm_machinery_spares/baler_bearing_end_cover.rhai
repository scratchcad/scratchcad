// Round baler roller bearing end cover for a 4-bolt flange bearing: 95 mm square flange 3 mm thick with 8 mm corner radius and four 11 mm holes on a 76 mm square, carrying a 62 mm cup 22 mm tall with a 2.5 mm wall and a 6 mm grease relief hole in its end, to keep chaff out of the shaft end
let flange = 95.0; // [70.0, 130.0] Flange size (mm)
let bolt_square = 76.0; // [54.0, 106.0] Bolt square (mm)
let cup_d = 62.0; // [40.0, 85.0] Cup diameter (mm)
let cup_h = 22.0; // [12.0, 40.0] Cup height (mm)
const t = 3.0;
const wall = 2.5;
const hole_d = 11.0;
let half = flange / 2.0;
let bs = min(bolt_square, flange - 18.0) / 2.0;
let rc = min(cup_d / 2.0, bs * 1.414 - hole_d / 2.0 - 4.0);
let plate = box_from_corners([-half, -half, 0], [half, half, t]);
let plate = plate.fillet(8.0, plate.edges("|Z"));
let body = plate + cylinder([0, 0, t - 0.5], "Z", rc, cup_h + 0.5);
let cutters = [cylinder([0, 0, -1.0], "Z", rc - wall, t + cup_h - wall + 1.0), cylinder([0, 0, t], "Z", 3.0, cup_h + 1.0)];
for c in [[-bs, -bs], [bs, -bs], [-bs, bs], [bs, bs]] {
    cutters.push(cylinder([c[0], c[1], -1.0], "Z", hole_d / 2.0, t + 2.0));
}
body - fuse_all(cutters)
