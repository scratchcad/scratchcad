// 15 mm copper compression nut with olive: 22 mm hex 13 mm long, internal 1/2 in thread zone, brass olive 15 x 8 mm
let hex = 22.0; // [17.0, 32.0] Hex size (mm)
let length = 13.0; // [9.0, 18.0] Nut length (mm)
let pipe = 15.0; // [8.0, 19.7] Pipe size (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let nut = polygon(pts).to_face().extrude(length).chamfer(1.0, ">Z") - cylinder([0, 0, -1], "Z", pipe / 2.0 + 0.2, length + 2.0) - cylinder([0, 0, -1], "Z", 9.7, length - 3.0);
let olive = sketch("XZ").move_to(pipe / 2.0, 0).line_to(pipe / 2.0 + 1.0, 0).line_to(pipe / 2.0 + 2.0, 4.0).line_to(pipe / 2.0 + 1.0, 8.0).hline_to(pipe / 2.0).close().to_face().revolve("Z", 360).translate([0, 0, -9.0]);
[nut, olive]
