// 8 in (200 mm) shower arm, with escutcheon: 1/2 in pipe 21.3 mm OD, 2.8 mm wall, 45 degree bend of 40 mm radius, thread bands both ends, 60 mm wall flange
let pipe_od = 21.3; // [15.0, 27.0] Pipe outside diameter (mm)
let wall = 2.8; // [1.5, 4.0] Pipe wall (mm)
let straight = 150.0; // [80.0, 250.0] Straight length from the wall (mm)
let bend_angle = 45.0; // [0.0, 90.0] Bend angle (degrees)
let bend_radius = 40.0; // [25.0, 80.0] Bend radius (mm)
let drop = 40.0; // [20.0, 80.0] Length after the bend (mm)
let flange_diameter = 60.0; // [40.0, 90.0] Wall flange diameter (mm)
let ro = pipe_od / 2.0;
let ri = ro - wall;
let a = bend_angle * PI() / 180.0;
let c = [0, straight, -bend_radius];
let p1 = [0, straight, 0];
let pm = [0, straight + bend_radius * (a / 2.0).sin(), -bend_radius + bend_radius * (a / 2.0).cos()];
let p2 = [0, straight + bend_radius * a.sin(), -bend_radius + bend_radius * a.cos()];
let d2 = [0, a.cos(), -a.sin()];
let p3 = [0, p2[1] + drop * d2[1], p2[2] + drop * d2[2]];
let edges = [line([0, 0, 0], p1)];
if bend_angle > 0.5 { edges.push(arc(p1, pm, p2)); }
edges.push(line(p2, p3));
let section = face(circle([0, 0, 0], [0, 1, 0], ro), [circle([0, 0, 0], [0, 1, 0], ri)]);
let arm = section.sweep(wire(edges));
let grooves = [];
for i in 0..6 {
    grooves.push(torus(ro + 0.2, 0.6).rotate_x(90.0).translate([0, 2.0 + i.to_float() * 1.8, 0]));
    grooves.push(torus(ro + 0.2, 0.6).rotate_x(90.0).translate([0, -2.0 - i.to_float() * 1.8, 0]).rotate_x(-bend_angle).translate(p3));
}
arm = arm - compound(grooves);
let rf = flange_diameter / 2.0;
let esc = sketch("XZ").move_to(ro + 0.3, 0).hline_to(rf).arc_to(rf * 0.7, 6.0, ro + 3.0, 10.0).hline_to(ro + 0.3).close().to_face().revolve("Z", 360)
    .rotate_x(-90.0).translate([0, 25.0, 0]);
compound([arm, esc])
