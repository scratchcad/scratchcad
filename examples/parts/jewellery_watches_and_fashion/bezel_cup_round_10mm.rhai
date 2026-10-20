// Bezel cup for a 10 mm round cabochon: 0.4 mm bezel wall 1.6 mm high above a 0.65 mm seat ledge, closed 0.6 mm base with a 3 mm light hole, eight 1 mm gallery holes
let stone_diameter = 10.0; // [4.0, 20.0] Stone diameter (mm)
let bezel_height = 1.6; // [0.8, 3.0] Bezel height above the seat (mm)
let wall = 0.4; // [0.25, 0.8] Bezel wall (mm)
let seat_height = 1.6; // [1.0, 3.0] Seat height (mm)
let gallery_holes = 8; // [0, 16] Number of gallery holes
let ri = stone_diameter / 2.0 + 0.05;
let ro = ri + wall;
let rl = ri - min(0.65, stone_diameter / 8.0);
let profile = sketch("XZ")
    .move_to(1.5, 0)
    .hline_to(ro)
    .vline_to(seat_height + bezel_height)
    .hline_to(ri)
    .vline_to(seat_height)
    .hline_to(rl)
    .vline_to(0.6)
    .hline_to(1.5)
    .close();
let cup = profile.to_face().revolve("Z", 360);
let holes = [];
for i in 0..gallery_holes {
    holes.push(cylinder([rl - 0.5, 0, 0.6 + (seat_height - 0.6) / 2.0], "X", 0.5, ro - rl + 1.0).rotate_z(i.to_float() * 360.0 / gallery_holes.to_float()));
}
if gallery_holes > 0 { cup = cup - compound(holes); }
cup
