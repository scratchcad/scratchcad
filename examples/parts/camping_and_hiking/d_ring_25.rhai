// 25 mm D-ring: 4 mm wire, 27 mm inside straight, 22 mm inside depth
let inside_w = 27.0; // [15.0, 30.0] Inside straight length (mm)
let depth = 22.0; // [16.0, 40.0] Inside depth (mm)
let wire_d = 4.0; // [2.5, 6.0] Wire diameter (mm)
let r = wire_d / 2.0;
let R = inside_w / 2.0 + r;
let leg = depth - R + 2.0 * r;
let straight = cylinder([-R, 0, 0], "X", r, 2.0 * R);
let legs = cylinder([-R, 0, 0], "Y", r, leg) + cylinder([R, 0, 0], "Y", r, leg);
let corners = sphere([-R, 0, 0], r) + sphere([R, 0, 0], r);
let bow = torus(R, r).translate([0, leg, 0]) & box_from_corners([-R - wire_d, leg, -wire_d], [R + wire_d, leg + R + wire_d, wire_d]);
straight + legs + corners + bow
