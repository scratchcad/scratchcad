// Five-point star cookie cutter: 70 mm tip to tip, inner radius 15 mm, 0.8 mm wall 18 mm tall, 3 mm pressing rim on top
let tip_radius = 35.0; // [20.0, 60.0] Tip radius (mm)
let inner_radius = 15.0; // [8.0, 30.0] Inner radius (mm)
let points = 5; // [4, 8] Number of points
let height = 18.0; // [10.0, 30.0] Cutter height (mm)
let wall = 0.8; // [0.5, 1.5] Wall thickness (mm)
let rim_width = 3.0; // [1.5, 6.0] Rim width (mm)
let ri = min(inner_radius, tip_radius - 4.0);
let pts = [];
for i in 0..(2 * points) {
    let a = (90.0 + i.to_float() * 180.0 / points.to_float()) * PI() / 180.0;
    let rr = if i % 2 == 0 { tip_radius } else { ri };
    pts.push([rr * a.cos(), rr * a.sin()]);
}
let edge = polygon(pts);
let cutter = face(edge.offset(wall), [edge]).extrude([0, 0, height]);
let rim = face(edge.offset(wall + rim_width), [edge]).extrude([0, 0, 1.5]).translate([0, 0, height - 1.5]);
cutter + rim
