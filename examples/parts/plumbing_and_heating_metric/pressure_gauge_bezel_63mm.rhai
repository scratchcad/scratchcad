// Boiler pressure gauge bezel for a 63 mm dial gauge: 68 mm outside, 56 mm window, 8 mm deep ring with 2 mm front lip, 63.5 mm case seat 6 mm deep, 3 retaining lugs
let gauge = 63.0; // [40.0, 100.0] Gauge case diameter (mm)
let window = 56.0; // [32.0, 92.0] Window diameter (mm)
let depth = 8.0; // [5.0, 14.0] Bezel depth (mm)
let lip = 2.0; // [1.2, 3.5] Front lip thickness (mm)
let rs = gauge / 2.0 + 0.25;
let ro = rs + 2.25;
let rw = min(window / 2.0, rs - 2.0);
let profile = polygon([[rw, 0, depth], [ro - 1.0, 0, depth], [ro, 0, depth - 1.0], [ro, 0, 0], [rs, 0, 0], [rs, 0, depth - lip], [rw, 0, depth - lip]]);
let ring = profile.to_face().revolve("Z", 360);
let lugs = [];
for k in 0..3 {
    lugs.push(box_from_corners([rs - 1.0, -2.5, 0], [rs + 0.5, 2.5, 1.2]).rotate_z(k.to_float() * 120.0));
}
fuse_all([ring] + lugs)
