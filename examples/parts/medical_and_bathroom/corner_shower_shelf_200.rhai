// Corner shower shelf: 200 mm quarter-round, 8 mm thick, 12 mm lip on the curved edge, drain holes, two screw tabs on each wall
let radius = 200.0; // [120.0, 300.0] Shelf radius (mm)
let thickness = 8.0; // [5.0, 12.0] Shelf thickness (mm)
let lip = 12.0; // [0.0, 25.0] Front lip height (mm)
let drain = 6.0; // [3.0, 10.0] Drain hole diameter (mm)
let R = radius;
let quarter = box(R, R, thickness + lip + 30.0).translate([0, 0, -10.0]);
let shelf = cylinder(R, thickness) & quarter;
if lip > 0.0 {
    shelf += (cylinder([0, 0, thickness - 0.1], "Z", R, lip + 0.1) - cylinder([0, 0, thickness - 1.0], "Z", R - 4.0, lip + 2.0)) & quarter;
}
let tabs = [];
for f in [0.3, 0.75] {
    tabs.push(box_from_corners([-0.1, R * f - 12.0, thickness - 0.1], [4.0, R * f + 12.0, thickness + 25.0]) - cylinder([-1.0, R * f, thickness + 15.0], "X", 2.2, 6.0));
    tabs.push(box_from_corners([R * f - 12.0, -0.1, thickness - 0.1], [R * f + 12.0, 4.0, thickness + 25.0]) - cylinder([R * f, -1.0, thickness + 15.0], "Y", 2.2, 6.0));
}
shelf = fuse_all([shelf] + tabs);
let holes = [];
for i in 1..5 {
    let rr = R * i.to_float() / 5.0;
    let n = i * 2 + 1;
    for j in 0..n {
        let a = (j.to_float() + 0.5) * 90.0 / n.to_float();
        holes.push(cylinder([rr, 0, -1.0], "Z", drain / 2.0, thickness + 2.0).rotate_z(a));
    }
}
shelf - compound(holes)
