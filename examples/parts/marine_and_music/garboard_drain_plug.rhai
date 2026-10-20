// Garboard drain plug and housing: 1/2 in NPT plug with a 22 mm square head and lanyard eye, flanged housing 50 mm across with three screw holes
let flange = 50.0; // [40.0, 70.0] Flange diameter (mm)
let housing = cylinder(flange / 2.0, 4.0).chamfer(1.0, ">Z") + cylinder([0, 0, -20.0], "Z", 13.0, 20.1) - cone(10.5, 10.0, 26.0).translate([0, 0, -21.0]);
for k in 0..3 { housing -= cylinder([flange / 2.0 - 6.0, 0, -1], "Z", 2.0, 6.0).rotate("Z", k.to_float() * 120.0); }
let plug = cone(10.4, 9.9, 18.0).translate([0, 0, -16.0]) + box_centered(22.0, 22.0, 8.0).translate([0, 0, 6.0]).chamfer(1.0, ">Z") + (torus(6.0, 2.0).rotate_x(90.0).translate([0, 0, 14.0]) - box_centered(20.0, 10.0, 10.0).translate([0, 0, 7.0]));
compound([housing, plug.translate([0, 0, 4.5])])
