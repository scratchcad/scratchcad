// Badminton racket handle butt cap: octagonal cup for a 25 mm handle, 1.5 mm wall, 12 mm tall, domed 2 mm end, 0.5 mm chamfered flats
let handle_af = 25.0; // [20.0, 30.0] Handle size across flats (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let height = 12.0; // [8.0, 20.0] Cap height (mm)
let socket_depth = 9.0; // [5.0, 16.0] Socket depth (mm)
const dome = 2.0;
fn octagon(af) {
    let rc = af / 2.0 / (PI() / 8.0).cos();
    let pts = [];
    for i in 0..8 { let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
    polygon(pts)
}
let outer_af = handle_af + 2.0 * wall;
let cup = octagon(outer_af).to_face().extrude([0, 0, height]);
let cap_r = outer_af / 2.0 / (PI() / 8.0).cos();
let cap = cup & (cylinder(cap_r + 1.0, height - dome) + sphere([0, 0, height - (cap_r * cap_r + dome * dome) / (2.0 * dome)], (cap_r * cap_r + dome * dome) / (2.0 * dome)));
let sd = min(socket_depth, height - dome - 1.0);
cap - octagon(handle_af).to_face().extrude([0, 0, sd + 1.0]).translate([0, 0, -1.0])
