// Melon support cradle: hanging sling cup for vertically grown melons up to 150 mm, 120 mm diameter dished bowl 2.5 mm thick with 8 mm drain holes on a 16 mm hex grid, three 6 mm hanging eyes on 10 mm lugs
// # Bowl
let bowl_d = 120.0; // [80.0, 180.0] Bowl diameter (mm)
let bowl_depth = 30.0; // [15.0, 50.0] Bowl depth (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
// # Holes
let hole_d = 8.0; // [5.0, 12.0] Drain hole diameter (mm)
let pitch = 16.0; // [12.0, 25.0] Hole pitch (mm)
let R = bowl_d / 2.0;
let outer = sketch("XZ").move_to(0, 0).hline_to(R * 0.45).line_to(R * 0.85, bowl_depth * 0.55).line_to(R, bowl_depth).hline_to(R - wall).line_to(R * 0.85 - wall * 0.9, bowl_depth * 0.55 + wall * 0.4).line_to(R * 0.45 - wall * 0.4, wall).hline_to(0).close().to_face().revolve("Z", 360);
let holes = [];
let n = (R / pitch).floor().to_int();
for i in -n..=n {
    for j in -n..=n {
        let x = i.to_float() * pitch + (j % 2).abs().to_float() * pitch / 2.0;
        let y = j.to_float() * pitch * 0.866;
        if (x * x + y * y).sqrt() < R * 0.72 { holes.push(cylinder([x, y, -1.0], "Z", hole_d / 2.0, bowl_depth + 2.0)); }
    }
}
let lugs = [];
let eyes = [];
for k in 0..3 {
    let a = k.to_float() * 120.0;
    lugs.push(box_from_corners([R - wall - 0.5, -5.0, bowl_depth - 0.01], [R + 4.0, 5.0, bowl_depth + 12.0]).fillet(4.5, "|X and >Z").rotate_z(a));
    eyes.push(cylinder([R - wall - 1.0, 0, bowl_depth + 6.5], "X", 3.0, wall + 6.0).rotate_z(a));
}
outer - fuse_all(holes) + fuse_all(lugs) - compound(eyes)
