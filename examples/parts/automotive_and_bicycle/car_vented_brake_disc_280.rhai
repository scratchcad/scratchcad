// Vented front brake disc 280 x 22 mm: two 7 mm plates, 36 straight vanes, 50 mm hat, 66.1 mm bore, 5x114.3 bolt holes
let dia = 280.0; // [240.0, 340.0] Disc diameter (mm)
let ro = dia / 2.0;
let ri = ro - 45.0;
let lower = cylinder(ro, 7.0) - cylinder([0, 0, -1], "Z", ri, 9.0);
let upper = cylinder([0, 0, 15.0], "Z", ro, 7.0) - cylinder([0, 0, 14.0], "Z", ri - 9.0, 9.0);
let parts = [lower, upper];
for k in 0..36 { parts.push(box_from_corners([ri + 1.0, -2.0, 6.5], [ro - 1.0, 2.0, 15.5]).rotate("Z", k.to_float() * 10.0)); }
parts.push(cylinder([0, 0, 18.0], "Z", ri - 3.0, 32.0) - cylinder([0, 0, 17.0], "Z", ri - 9.0, 34.0));
parts.push(cylinder([0, 0, 45.0], "Z", ri - 3.0, 5.0));
let disc = fuse_all(parts) - cylinder([0, 0, 40.0], "Z", 33.05, 20.0);
for k in 0..5 { disc -= cylinder([57.15, 0, 40.0], "Z", 7.1, 20.0).rotate("Z", k.to_float() * 72.0); }
disc
