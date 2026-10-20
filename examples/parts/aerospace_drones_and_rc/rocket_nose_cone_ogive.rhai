// Tangent-ogive model rocket nose cone for BT-60 (41.6 mm): 120 mm ogive, 40 mm hollow shoulder for a 40.5 mm bore
let R = 20.8; // [9.0, 33.0] Base radius (mm)
let L = 120.0; // [60.0, 250.0] Ogive length (mm)
let rho = (R * R + L * L) / (2.0 * R);
let pts = [[0, 0, L]];
for i in 1..=30 { let x = L * i.to_float() / 30.0; pts.push([sqrt(rho * rho - (L - x) * (L - x)) + R - rho, 0, L - x]); }
let profile = face(wire([spline(pts), line([R, 0, 0], [0, 0, 0]), line([0, 0, 0], [0, 0, L])]));
let cone = profile.revolve("Z", 360);
let shoulder = cylinder([0, 0, -40.0], "Z", R - 0.55, 40.5) - cylinder([0, 0, -41.0], "Z", R - 2.0, 40.5);
cone + shoulder
