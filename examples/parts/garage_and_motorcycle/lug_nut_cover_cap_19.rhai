// Chrome-style lug nut cover cap for 19 mm hex nuts: 22 mm hex outside, 19.2 mm hex socket 25 mm deep, 30 mm tall with a domed top
let nut_af = 19.2; // [17.2, 21.2] Socket across flats (mm)
let wall = 1.4; // [1.0, 2.5] Wall thickness (mm)
let height = 30.0; // [20.0, 40.0] Cap height (mm)
let socket_depth = 25.0; // [15.0, 35.0] Socket depth (mm)
let outer_af = nut_af + 2.0 * wall;
let rc = outer_af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let dome_z = height - outer_af / 2.0;
let hex = polygon(pts).to_face().extrude([0, 0, height]);
let shape = cylinder(rc, dome_z) + sphere([0, 0, dome_z], rc);
let cap = hex & shape;
let ri = nut_af / sqrt(3.0);
let ipts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; ipts.push([ri * a.cos(), ri * a.sin()]); }
let sd = min(socket_depth, dome_z + 2.0);
cap - polygon(ipts).to_face().extrude([0, 0, sd + 1.0]).translate([0, 0, -1.0])
