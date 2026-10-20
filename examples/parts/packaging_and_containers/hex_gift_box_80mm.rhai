// Hexagonal gift box, 80 mm across corners, 40 mm tall, 2 mm walls and floor, with a 12 mm telescoping lid that slides over it with 0.3 mm clearance, shown side by side
let across_corners = 80.0; // [40.0, 160.0] Box size across corners (mm)
let height = 40.0; // [15.0, 100.0] Box height (mm)
let wall = 2.0; // [1.2, 4.0] Wall thickness (mm)
let lid_height = 12.0; // [6.0, 30.0] Lid height (mm)
const clearance = 0.3;
fn hexagon(rc, z) {
    let pts = [];
    for i in 0..6 {
        let a = (i.to_float() * 60.0) * PI() / 180.0;
        pts.push([rc * a.cos(), rc * a.sin(), z]);
    }
    polygon(pts)
}
// offsetting a hexagon's sides by t moves its corners by t / cos(30)
let k = 1.0 / (30.0 * PI() / 180.0).cos();
let rc = across_corners / 2.0;
let box_body = hexagon(rc, 0).to_face().extrude([0, 0, height]) - hexagon(rc - wall * k, wall).to_face().extrude([0, 0, height]);
let rl = rc + clearance * k;
let lid = hexagon(rl + wall * k, 0).to_face().extrude([0, 0, lid_height]) - hexagon(rl, -1.0).to_face().extrude([0, 0, lid_height - wall + 1.0]);
[box_body, lid.translate([2.0 * rc + 15.0, 0, 0])]
