// Handlebar end plug for 22.2 mm bars (18 mm ID): 24 mm cap 4 mm, 15 mm expanding plug with 4 slits
let bar_id = 18.0; // [15.0, 22.0] Bar inside diameter (mm)
let cap = 24.0; // [22.0, 30.0] Cap diameter (mm)
let plug_l = 15.0; // [10.0, 25.0] Plug length (mm)
let c = cylinder(cap / 2.0, 4.0);
let cc = c.fillet(1.5, c.edges(">Z"));
let plug = cylinder([0, 0, -plug_l], "Z", bar_id / 2.0 + 0.3, plug_l + 0.01) - cylinder([0, 0, -plug_l - 1.0], "Z", bar_id / 2.0 - 2.0, plug_l);
let slits = box_centered(1.2, bar_id + 2.0, plug_l).translate([0, 0, -plug_l / 2.0 - 1.0]) + box_centered(bar_id + 2.0, 1.2, plug_l).translate([0, 0, -plug_l / 2.0 - 1.0]);
cc + plug - slits
