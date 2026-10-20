// Toothbrush holder cup: 80 mm cup 100 mm tall, 2.5 mm wall, top insert with four 16 mm brush holes around a 32 mm toothpaste hole, drain hole in the base
let diameter = 80.0; // [60.0, 110.0] Cup diameter (mm)
let height = 100.0; // [70.0, 140.0] Cup height (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let brushes = 4; // [2, 8] Number of brush holes
let brush_hole = 16.0; // [10.0, 22.0] Brush hole diameter (mm)
let paste_hole = 32.0; // [0.0, 40.0] Toothpaste hole diameter (mm)
let R = diameter / 2.0;
let cup = cylinder(R, height).fillet(4.0, "<Z") - cylinder([0, 0, wall], "Z", R - wall, height);
let top = cylinder([0, 0, height - 3.0], "Z", R - wall + 0.1, 3.0).fillet(1.0, ">Z");
let rp = min(paste_hole / 2.0, R * 0.45);
let rh = brush_hole / 2.0;
let rc = (rp + R - wall) / 2.0 + 1.0;
let holes = [];
if rp > 1.0 { holes.push(cylinder([0, 0, height - 4.0], "Z", rp, 5.0)); }
for i in 0..brushes {
    holes.push(cylinder([rc, 0, height - 4.0], "Z", min(rh, (R - wall - rp) / 2.0 - 1.0), 5.0).rotate_z(45.0 + i.to_float() * 360.0 / brushes.to_float()));
}
holes.push(cylinder([0, 0, -1.0], "Z", 4.0, wall + 2.0));
fuse_all([cup, top]) - compound(holes)
