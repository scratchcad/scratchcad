// Miniature circuit breaker toggle handle (18 mm module): 9 mm wide lever, 16 mm tall, 3 mm pivot pin bore, ribbed finger grip, ON/OFF window flag
let width = 9.0; // [6.0, 14.0] Handle width (mm)
let height = 16.0; // [10.0, 25.0] Lever height above the pivot (mm)
let pivot_d = 3.0; // [2.0, 5.0] Pivot bore (mm)
let tilt = 15.0; // [-30.0, 30.0] Lever tilt (degrees)
const pr = 4.5;
let lever = sketch("YZ").move_to(-pr, 0).line_to(-3.5, height).arc_to(0, height + 1.5, 3.5, height).line_to(pr, 0).arc_to(0, -pr, -pr, 0).face();
let body = lever.extrude([width, 0, 0]);
let ribs = [];
for i in 0..4 {
    let z = height - 2.5 - i.to_float() * 2.2;
    ribs.push(cylinder([-0.5, 0, z], "X", 0.6, width + 1.0).translate([0, -3.3 - (height - z) * 0.0, 0]));
}
body -= fuse_all(ribs);
let flag = box_from_corners([1.0, -pr - 3.0, -pr - 2.0], [width - 1.0, -1.0, -1.0]);
let h = (body + flag) - cylinder([-1, 0, 0], "X", pivot_d / 2.0, width + 2.0);
h.rotate("X", tilt)
