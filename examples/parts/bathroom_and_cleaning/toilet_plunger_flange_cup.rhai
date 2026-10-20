// Toilet flange plunger cup: 152 mm bell 100 mm tall, 56 mm fold-out flange 40 mm long, 4 mm rubber wall, blind 24 mm socket for the handle
let bell_r = 76.0; // [60.0, 90.0] Bell radius (mm)
let flange_r = 28.0; // [22.0, 35.0] Flange outer radius (mm)
let flange_l = 40.0; // [25.0, 55.0] Flange length (mm)
let socket_d = 24.0; // [20.0, 30.0] Handle socket bore (mm)
let k = bell_r / 76.0;
let rs = socket_d / 2.0;
let pts = [
    [rs + 6.0, 0, 100.0], [rs + 6.0, 0, 78.0], [50.0 * k, 0, 70.0], [72.0 * k, 0, 45.0], [bell_r, 0, 20.0], [74.0 * k, 0, 8.0],
    [flange_r + 2.0, 0, 0], [flange_r, 0, -flange_l], [flange_r - 4.0, 0, -flange_l], [flange_r - 4.0, 0, 2.0],
    [70.0 * k, 0, 11.0], [72.0 * k, 0, 22.0], [68.0 * k, 0, 43.0], [47.0 * k, 0, 64.0], [0, 0, 71.0], [0, 0, 76.0], [rs, 0, 76.0], [rs, 0, 100.0]
];
polygon(pts).to_face().revolve("Z", 360)
