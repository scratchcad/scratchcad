// Golf grip end cap: 25 mm domed-flat cap 6 mm tall with a 15 mm plug 10 mm long (3 ribs) for the grip vent hole, 1 mm top chamfer
let cap_d = 25.0; // [20.0, 30.0] Cap diameter (mm)
let plug_d = 15.0; // [10.0, 18.0] Plug diameter (mm)
let cap = cylinder([0, 0, 0], "Z", cap_d / 2.0, 6.0);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let plug = cylinder([0, 0, -10.0], "Z", plug_d / 2.0 - 0.5, 10.01);
let ribs = [];
for z in [-8.0, -5.0, -2.0] { ribs.push(cone(plug_d / 2.0 - 0.5, plug_d / 2.0 + 0.3, 1.5).translate([0, 0, z])); }
cap + plug + fuse_all(ribs) - cylinder([0, 0, -11.0], "Z", plug_d / 2.0 - 2.0, 9.0)
