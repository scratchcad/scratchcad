// Recessed speaker handle cup: 190 x 110 mm flange 3 mm thick over a 160 x 80 mm dish 45 mm deep, 2.5 mm walls, a 20 x 12 mm grip bar along one long wall just under the flange and six 4.5 mm screw holes
let depth = 45.0; // [30.0, 60.0] Dish depth (mm)
let dish_l = 160.0; // [120.0, 200.0] Dish length (mm)
const wall = 2.5;
let flange = box_centered(dish_l + 30.0, 110.0, 3.0).translate([0, 0, -1.5]);
let dish = box_centered(dish_l, 80.0, depth).translate([0, 0, -depth / 2.0]);
let cup = flange + dish - box_centered(dish_l - 2.0 * wall, 80.0 - 2.0 * wall, depth).translate([0, 0, -depth / 2.0 + wall]);
let bar = box_centered(dish_l - 2.0 * wall + 0.02, 20.0, 12.0).translate([0, -40.0 + wall + 10.0, -8.0]);
let holes = [];
for x in [-dish_l / 2.0 - 7.5, 0.0, dish_l / 2.0 + 7.5] { for sy in [-1.0, 1.0] { holes.push(cylinder([x, sy * 47.5, -5.0], "Z", 2.25, 10.0)); } }
cup + bar - fuse_all(holes)
