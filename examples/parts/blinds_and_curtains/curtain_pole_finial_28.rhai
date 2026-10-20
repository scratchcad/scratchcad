// 28 mm curtain pole finial: 50 mm ball on a 34 mm collar, 25 mm socket 30 mm deep
let pole = 28.0; // [19.0, 35.0] Pole diameter (mm)
let ball = 50.0; // [30.0, 70.0] Ball diameter (mm)
let socket_l = 30.0; // [15.0, 40.0] Socket depth (mm)
let collar = cylinder([0, 0, 0], "X", pole / 2.0 + 3.0, socket_l + 4.0);
let neck = cone(pole / 2.0 + 3.0, pole / 2.0 - 2.0, 10.0).rotate_y(90.0).translate([socket_l + 3.99, 0, 0]);
let b = sphere([socket_l + 13.0 + ball / 2.0 - 4.0, 0, 0], ball / 2.0);
collar + neck + b - cylinder([-1, 0, 0], "X", pole / 2.0 + 0.3, socket_l + 1.0) - cylinder([socket_l * 0.5, 0, -pole], "Z", 1.6, pole)
