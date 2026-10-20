// M3 hex standoff, 5.5 mm across flats, 30 mm long, tapped 2.5 mm through, chamfered ends
let len = 30.0; // [5.0, 60.0] Length (mm)
let rc = 5.5 / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; pts.push([rc * a.cos(), rc * a.sin()]); }
polygon(pts).to_face().extrude(len).chamfer(0.3, ">Z or <Z") - cylinder([0, 0, -1], "Z", 1.25, len + 2.0)
