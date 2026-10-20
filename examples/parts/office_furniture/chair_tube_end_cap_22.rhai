// Ribbed tube insert foot for 22 mm x 1.5 mm chair tube: 22 mm cap 4 mm, 18.6 mm ribbed plug 15 mm with 4 fins
let tube = 22.0; // [16.0, 32.0] Tube OD (mm)
let wall = 1.5; // [1.0, 2.5] Tube wall (mm)
let plug_l = 15.0; // [10.0, 25.0] Plug length (mm)
let cap = cylinder(tube / 2.0, 4.0);
let c = cap.fillet(1.5, cap.edges("<Z"));
let id = tube - 2.0 * wall;
let plug = cylinder([0, 0, 3.99], "Z", id / 2.0 - 1.0, plug_l);
let fins = [];
for k in 0..3 { fins.push(cylinder([0, 0, 6.0 + k.to_float() * 4.0], "Z", id / 2.0 + 0.4, 1.0)); }
c + plug + fuse_all(fins) - cylinder([0, 0, 5.0], "Z", id / 2.0 - 3.0, plug_l)
