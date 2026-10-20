// Outboard fuel primer bulb holder: 3 mm strip 100 x 16 mm with 3 mm rounded ends, two M5 holes (5.3 mm) for screwing to the boat, and two 270 degree snap clips for the 10 mm fuel hose either side of the bulb, 85 mm apart
let hose_d = 10.0; // [6.0, 16.0] Fuel hose diameter (mm)
let clip_spacing = 85.0; // [60.0, 120.0] Clip spacing (mm)
let width = 16.0; // [10.0, 25.0] Strip width (mm)
const t = 3.0;
let length = clip_spacing + 2.0 * (hose_d / 2.0 + t) + 6.0;
let strip = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let strip = strip.fillet(3.0, strip.edges("|Z"));
let ri = hose_d / 2.0;
let ro = ri + 2.0;
let clips = [];
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * clip_spacing / 2.0;
    let zc = t + ri;
    clips.push(cylinder([x, -width / 2.0, zc], "Y", ro, width) + box_from_corners([x - ro, -width / 2.0, t - 0.5], [x + ro, width / 2.0, zc]));
    cuts.push(cylinder([x, -width / 2.0 - 1.0, zc], "Y", ri, width + 2.0));
    cuts.push(box_from_corners([x - ri * 0.7, -width / 2.0 - 1.0, zc + ri * 0.5], [x + ri * 0.7, width / 2.0 + 1.0, zc + ro + 1.0]));
    cuts.push(cylinder([s * clip_spacing / 4.0, 0, -1.0], "Z", 2.65, t + 2.0));
}
(strip + fuse_all(clips)) - fuse_all(cuts)
