// IV pole accessory clamp for a 25 mm pole: 40 mm collar 30 mm tall, M8 thumbscrew boss (6.8 mm tap) on one side and a 40 x 40 x 5 mm accessory plate with four 5.5 mm holes at 28 mm on the other
let pole_d = 25.0; // [19.0, 32.0] Pole diameter (mm)
let height = 30.0; // [20.0, 50.0] Collar height (mm)
let plate = 40.0; // [30.0, 60.0] Accessory plate size (mm)
const wall = 7.0;
let ri = pole_d / 2.0 + 0.3;
let ro = ri + wall;
let c = cylinder([0, 0, 0], "Z", ro, height);
let boss = cylinder([-ro + 2.0, 0, height / 2.0], "-X", 7.0, 8.0);
let arm = box_from_corners([0, -10.0, 0], [ro + 8.0, 10.0, height]);
let p = box_from_corners([ro + 8.0, -plate / 2.0, height / 2.0 - plate / 2.0], [ro + 13.0, plate / 2.0, height / 2.0 + plate / 2.0]);
p = p.fillet(3.0, p.edges("|X"));
let body = c + boss + arm + p;
body = body - cylinder([0, 0, -1.0], "Z", ri, height + 2.0) - cylinder([-ro - 7.0, 0, height / 2.0], "X", 3.4, wall + 6.0);
let holes = [];
for sy in [-1.0, 1.0] {
    for sz in [-1.0, 1.0] {
        holes.push(cylinder([ro + 7.0, sy * 14.0, height / 2.0 + sz * 14.0], "X", 2.75, 7.0));
    }
}
body - compound(holes)
