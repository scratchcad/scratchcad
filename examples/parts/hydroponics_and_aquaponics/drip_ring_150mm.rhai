// Hydroponic top-feed drip ring, 150 mm: hollow 8 x 8 mm square-section ring on a 150 mm mean diameter with a 5 x 5 mm channel, 8 drip holes 1.5 mm on the underside, and a 1/4 inch barbed inlet (7 mm barb, 4 mm bore) 12 mm tall on top
let ring_d = 150.0; // [80.0, 250.0] Ring mean diameter (mm)
let holes = 8; // [4, 24] Number of drip holes
let hole_d = 1.5; // [1.0, 3.0] Drip hole diameter (mm)
const s = 8.0;
const c = 5.0;
let r = ring_d / 2.0;
let ring = face(polygon([[r - s / 2.0, 0, 0], [r + s / 2.0, 0, 0], [r + s / 2.0, 0, s], [r - s / 2.0, 0, s]])).revolve("Z", 360.0);
let barb = cylinder([r, 0, s - 0.5], "Z", 3.0, 8.5) + cone(3.5, 2.6, 4.0).translate([r, 0, s + 8.0]);
let body = ring + barb;
let channel = face(polygon([[r - c / 2.0, 0, (s - c) / 2.0], [r + c / 2.0, 0, (s - c) / 2.0], [r + c / 2.0, 0, (s + c) / 2.0], [r - c / 2.0, 0, (s + c) / 2.0]])).revolve("Z", 360.0);
let cuts = [channel, cylinder([r, 0, s / 2.0], "Z", 2.0, s + 10.0)];
for i in 0..holes {
    let a = (i.to_float() + 0.5) * 2.0 * PI() / holes.to_float();
    cuts.push(cylinder([r * cos(a), r * sin(a), -1.0], "Z", hole_d / 2.0, (s - c) / 2.0 + 2.0));
}
body - fuse_all(cuts)
