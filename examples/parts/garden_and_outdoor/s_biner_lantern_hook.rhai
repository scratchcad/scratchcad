// S-biner double gated lantern hook: two 26 mm loops of 4 mm wire, 61 mm overall, spring wire gates closing each loop
let loop_diameter = 26.0; // [16.0, 40.0] Loop diameter (mm)
let wire = 4.0; // [2.5, 6.0] Wire diameter (mm)
let gate_wire = 1.6; // [1.0, 2.5] Gate wire diameter (mm)
let R = loop_diameter / 2.0 + wire / 2.0;
let pt = |cy, deg| [R * (deg * PI() / 180.0).cos(), cy + R * (deg * PI() / 180.0).sin(), 0];
let upper = arc(pt.call(R, 30.0), pt.call(R, 150.0), pt.call(R, 270.0));
let lower = arc(pt.call(-R, 90.0), pt.call(-R, -30.0), pt.call(-R, -150.0));
let start = pt.call(R, 30.0);
let dir = [-(30.0 * PI() / 180.0).sin(), (30.0 * PI() / 180.0).cos(), 0];
let body = circle(start, dir, wire / 2.0).to_face().sweep(wire([upper, lower]));
let tip1 = pt.call(R, 30.0);
let tip2 = pt.call(-R, -150.0);
let parts = [body, sphere(tip1, wire / 2.0), sphere(tip2, wire / 2.0)];
// gates: from the waist to just short of each tip
let g = gate_wire / 2.0;
let w1 = [0, wire * 0.15, 0];
let v1 = [tip1[0] - w1[0], tip1[1] - w1[1], 0];
let l1 = (v1[0] * v1[0] + v1[1] * v1[1]).sqrt() - wire / 2.0 - 0.6;
parts.push(cylinder(w1, v1, g, l1));
let w2 = [0, -wire * 0.15, 0];
let v2 = [tip2[0] - w2[0], tip2[1] - w2[1], 0];
let l2 = (v2[0] * v2[0] + v2[1] * v2[1]).sqrt() - wire / 2.0 - 0.6;
parts.push(cylinder(w2, v2, g, l2));
fuse_all(parts)
