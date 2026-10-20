// Raised pet bowl: 180 mm stand 90 mm tall with a 150 mm bowl recess 50 mm deep, rounded rim, four cut-out feet
let d = 180.0; // [140.0, 260.0] Stand diameter (mm)
let h = 90.0; // [50.0, 150.0] Stand height (mm)
let r = d / 2.0;
let stand = cylinder(r, h).fillet(6.0, ">Z") - sphere([0, 0, h + 85.0 - 50.0], 85.0);
for k in 0..4 { stand -= (cylinder([0, -r - 1.0, 0], "Y", r * 0.35, d + 2.0) & box_centered(2.0 * r, 2.0 * r, r * 0.7)).rotate_z(k.to_float() * 45.0); }
stand
