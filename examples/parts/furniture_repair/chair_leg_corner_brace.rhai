// Chair corner brace block: 75 mm triangular brace 20 mm thick with a 45 degree face, a 6 mm hanger bolt hole and 2 screw holes into the rails
let size = 75.0; // [50.0, 110.0] Brace leg length (mm)
let t = 20.0; // [15.0, 30.0] Thickness (mm)
let b = polygon([[0, 0], [size, 0], [size, 20.0], [20.0, size], [0, size]]).to_face().extrude([0, 0, t]);
b - cylinder([size * 0.35, size * 0.35, -1], "Z", 3.0, t + 2.0) - cylinder([size - 12.0, -1, t / 2.0], "Y", 2.0, 22.0) - cylinder([-1, size - 12.0, t / 2.0], "X", 2.0, 22.0)
