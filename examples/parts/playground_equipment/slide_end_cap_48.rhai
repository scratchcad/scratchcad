// Playground tube end cap for 48.3 mm OD steel tube: 54 mm domed-flat cap 8 mm tall with a 2 mm chamfer and a 25 mm ribbed plug for 3.2 mm wall tube (41.9 mm ID)
let tube_id = 41.9; // [38.0, 45.0] Tube inside diameter (mm)
let plug_l = 25.0; // [15.0, 35.0] Plug length (mm)
const cap_d = 54.0;
let cap = cylinder([0, 0, 0], "Z", cap_d / 2.0, 8.0);
let cap = cap.chamfer(2.0, cap.edges(">Z"));
let plug = cylinder([0, 0, -plug_l], "Z", tube_id / 2.0 - 0.6, plug_l + 0.01) - cylinder([0, 0, -plug_l - 1.0], "Z", tube_id / 2.0 - 3.0, plug_l);
let ribs = [];
for i in 0..3 { ribs.push(cone(tube_id / 2.0 - 0.6, tube_id / 2.0 + 0.4, 2.0).translate([0, 0, -plug_l + 3.0 + i.to_float() * (plug_l - 8.0) / 2.0])); }
cap + plug + fuse_all(ribs) - cylinder([0, 0, -plug_l - 1.0], "Z", tube_id / 2.0 - 3.0, plug_l)
