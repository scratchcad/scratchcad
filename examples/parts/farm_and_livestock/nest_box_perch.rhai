// Nest box entrance with perch: 32 mm hole in a 150 x 150 x 12 mm front, 20 mm perch dowel 60 mm, rain lip
let size = 150.0; // [100.0, 250.0] Front size (mm)
let hole = 32.0; // [25.0, 120.0] Entrance hole (mm)
let t = 12.0; // [8.0, 20.0] Board thickness (mm)
let board = box_from_corners([-size / 2.0, 0, 0], [size / 2.0, t, size]);
let perch = cylinder([0, -60.0, size * 0.65 - hole], "Y", 10.0, 60.01);
let lip = box_from_corners([-size / 2.0, -20.0, size - 8.0], [size / 2.0, 0.01, size]);
board + perch + lip - cylinder([0, -1, size * 0.65], "Y", hole / 2.0, t + 2.0)
