// Bed leg castor socket: push-in socket for a 22 mm round tube leg with 0.8 mm wall, 30 mm long with 4 grip fins, an 8 mm castor stem bore and a 30 mm cap flange
let tube_id = 20.4; // [15.0, 28.0] Tube inside diameter (mm)
let stem = 8.0; // [6.0, 11.0] Castor stem diameter (mm)
const length = 30.0;
let body = cylinder([0, 0, 0], "Z", tube_id / 2.0 - 0.6, length);
let fins = [];
for i in 0..4 { fins.push(box_centered(1.2, 1.5, length - 6.0).translate([tube_id / 2.0 - 0.4, 0, (length - 6.0) / 2.0 + 5.0]).rotate_z(i.to_float() * 90.0 + 45.0)); }
let flange = cylinder([0, 0, -3.0], "Z", tube_id / 2.0 + 3.0, 3.01);
body + fuse_all(fins) + flange - cylinder([0, 0, -4.0], "Z", stem / 2.0 + 0.1, length)
