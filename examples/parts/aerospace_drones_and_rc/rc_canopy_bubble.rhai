// RC plane bubble canopy: 120 mm long, 50 mm wide, 25 mm tall, 1.2 mm wall, lofted through six round sections and cut flat at the base
let len = 120.0; // [80.0, 200.0] Length (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let stations = [[0.0, 3.0], [0.17, 18.0], [0.42, 25.0], [0.71, 22.0], [0.96, 10.0], [1.0, 2.0]];
let outer = [];
let inner = [];
for st in stations {
    outer.push(circle([st[0] * len, 0, 0], [1, 0, 0], st[1]));
    if st[0] > 0.0 && st[0] < 1.0 { inner.push(circle([st[0] * len, 0, 0], [1, 0, 0], st[1] - wall)); }
}
let shell = loft(outer, true) - loft(inner, true);
shell & box_from_corners([-5, -40, 0], [len + 5.0, 40, 40])
