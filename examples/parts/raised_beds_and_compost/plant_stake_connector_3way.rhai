// Plant stake connector, 3-way corner: 11 mm stake sockets 25 mm deep on X, Y and Z axes, 2 mm walls
let stake = 11.0; // [8.0, 16.0] Stake diameter (mm)
let depth = 25.0; // [15.0, 35.0] Socket depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let r = stake / 2.0 + wall;
let hub = sphere(r + 1.0);
let socks = cylinder([0, 0, 0], "X", r, depth + r) + cylinder([0, 0, 0], "Y", r, depth + r) + cylinder([0, 0, 0], "Z", r, depth + r);
let holes = cylinder([r - 0.5, 0, 0], "X", stake / 2.0 + 0.2, depth + 2.0) + cylinder([0, r - 0.5, 0], "Y", stake / 2.0 + 0.2, depth + 2.0) + cylinder([0, 0, r - 0.5], "Z", stake / 2.0 + 0.2, depth + 2.0);
hub + socks - holes
