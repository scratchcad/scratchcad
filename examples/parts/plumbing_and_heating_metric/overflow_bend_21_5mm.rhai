// 21.5 mm overflow pipe 90 degree solvent-weld bend: two 21.7 mm sockets 18 mm deep, 1.8 mm wall, mitred corner, 17 mm through bore, 35 mm legs from the corner
let pipe = 21.5; // [15.0, 32.0] Pipe diameter (mm)
let wall = 1.8; // [1.4, 3.0] Wall thickness (mm)
let leg = 35.0; // [25.0, 60.0] Leg length to the corner (mm)
let socket_depth = 18.0; // [10.0, 25.0] Socket depth (mm)
let rs = pipe / 2.0 + 0.1;
let ro = rs + wall;
let rb = rs - 2.2;
let sd = min(socket_depth, leg - ro - 2.0);
let mitre_x = box_from_corners([0, -100, -200], [200, 100, 200]).rotate_y(45.0);
let mitre_z = box_from_corners([-200, -100, -200], [0, 100, 200]).rotate_y(45.0);
let outer = (cylinder([-ro - 1.0, 0, 0], "X", ro, leg + ro + 1.0) & mitre_x) + (cylinder([0, 0, -ro - 1.0], "Z", ro, leg + ro + 1.0) & mitre_z);
let inner = (cylinder([-rb - 1.0, 0, 0], "X", rb, leg + rb + 2.0) & mitre_x) + (cylinder([0, 0, -rb - 1.0], "Z", rb, leg + rb + 2.0) & mitre_z);
let sockets = cylinder([leg - sd, 0, 0], "X", rs, sd + 1.0) + cylinder([0, 0, leg - sd], "Z", rs, sd + 1.0);
outer - inner - sockets
