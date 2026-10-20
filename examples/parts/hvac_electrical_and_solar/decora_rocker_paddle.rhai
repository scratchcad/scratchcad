// Decora-style rocker switch paddle: 33.3 x 66.7 mm face, 1.5 mm crowned top, 7 mm tall skirt, central pivot bosses with 3 mm pin bore and actuator rib underneath
let face_w = 33.3; // [25.0, 40.0] Paddle width (mm)
let face_h = 66.7; // [45.0, 75.0] Paddle length (mm)
let skirt = 7.0; // [4.0, 12.0] Skirt height (mm)
let rocker_angle = 3.0; // [0.0, 8.0] Rocker tilt (degrees)
const t = 1.5;
const crown = 1.5;
let top = sketch("YZ").move_to(-face_h / 2.0, 0).hline_to(face_h / 2.0).vline_to(skirt).arc_to(0, skirt + crown, -face_h / 2.0, skirt).close().to_face().extrude([face_w, 0, 0]).translate([-face_w / 2.0, 0, 0]);
let p = top.fillet(2.0, "|Z");
let inner = box_centered(face_w - 2.0 * t, face_h - 2.0 * t, skirt).translate([0, 0, skirt / 2.0 - t]).fillet(1.0, "|Z");
p -= inner;
let bosses = [];
for s in [-1.0, 1.0] { bosses.push(cylinder([s * (face_w / 2.0 - t - 2.6), -4.0, 2.0], "Y", 2.8, 8.0) - cylinder([s * (face_w / 2.0 - t - 2.6), -5.0, 2.0], "Y", 1.5, 10.0)); }
let rib = box_centered(3.0, face_h * 0.5, skirt - 2.0).translate([0, 0, (skirt - 2.0) / 2.0 + 0.5]);
fuse_all([p, rib] + bosses).rotate("X", rocker_angle)
