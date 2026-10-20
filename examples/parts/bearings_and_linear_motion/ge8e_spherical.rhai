// GE8E spherical plain bearing: 8 mm bore, 16 mm OD, inner ring 8 mm wide, outer ring 5 mm wide
let bore = 8.0; // [5.0, 9.0] Bore (mm)
let outer = 16.0; // [14.7, 47.0] Outside diameter (mm)
let inner_w = 8.0; // [5.0, 22.0] Inner ring width (mm)
let outer_w = 5.0; // [3.0, 18.0] Outer ring width (mm)
let ball_r = (bore / 2.0 + outer / 2.0) * 0.55 + 1.0;
let inner = (sphere(ball_r) & box_centered(outer, outer, inner_w)) - cylinder([0, 0, -inner_w], "Z", bore / 2.0, inner_w * 2.0);
let outer_ring = (cylinder([0, 0, -outer_w / 2.0], "Z", outer / 2.0, outer_w)) - sphere(ball_r + 0.05);
[inner, outer_ring]
