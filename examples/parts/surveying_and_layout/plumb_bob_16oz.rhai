// 16 oz brass plumb bob (about 450 g): 32 mm body 95 mm long, 60 degree point, 12 mm cap with a 3 mm string hole
let d = 32.0; // [20.0, 45.0] Body diameter (mm)
let length = 95.0; // [60.0, 130.0] Overall length (mm)
let tip_h = (d / 2.0) / (30.0 * PI() / 180.0).tan();
let p = sketch("XZ").move_to(0, 0).line_to(d / 2.0, tip_h).vline_to(length - 18.0).line_to(6.0, length - 6.0).vline_to(length).hline_to(0).close();
let bob = p.face().revolve("Z", 360);
bob - cylinder([0, 0, length - 10.0], "Z", 1.5, 11.0) - cylinder([-8.0, 0, length - 4.0], "X", 1.5, 16.0)
