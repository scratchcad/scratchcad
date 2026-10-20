// Trailer mudguard stay clamp: U-bolt saddle for a 50 x 50 mm square axle, 60 mm wide, 6 mm thick with two 10.5 mm holes 64 mm apart and a 20 mm round stay socket 30 mm long welded on top
let axle = 50.0; // [40.0, 60.0] Axle size (mm)
let stay = 20.0; // [16.0, 25.0] Stay tube OD (mm)
const t = 6.0;
let spacing = axle + 14.0;
let plate = box_centered(spacing + 22.0, 60.0, t).translate([0, 0, t / 2.0]);
let socket = cylinder([0, -30.0, t + stay / 2.0 + 2.0], "Y", stay / 2.0 + 3.0, 30.0) + box_from_corners([-stay / 2.0 - 3.0, -30.0, t - 0.01], [stay / 2.0 + 3.0, 0, t + stay / 2.0 + 2.0]);
let p = plate + socket - cylinder([0, -31.0, t + stay / 2.0 + 2.0], "Y", stay / 2.0 + 0.3, 27.0);
p - cylinder([-spacing / 2.0, 0, -1.0], "Z", 5.25, t + 2.0) - cylinder([spacing / 2.0, 0, -1.0], "Z", 5.25, t + 2.0)
