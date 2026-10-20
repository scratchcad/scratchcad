// Stainless prep table bullet foot for 1-5/8 in (41 mm) tube legs: 41 mm top tapering to 28 mm at the floor over 45 mm, with a 10.2 mm M12 tap hole 30 mm deep for the leveller stud and a 6 mm floor chamfer
let top_d = 41.3; // [35.0, 50.0] Top diameter (mm)
let foot_d = 28.0; // [22.0, 34.0] Floor diameter (mm)
let height = 45.0; // [30.0, 70.0] Foot height (mm)
let stud = 10.2; // [8.5, 14.0] Stud tap hole (mm)
const depth = 30.0;
let foot = face(polygon([[0, 0, 0], [foot_d / 2.0 - 3.0, 0, 0], [foot_d / 2.0, 0, 3.0], [top_d / 2.0, 0, height - 8.0], [top_d / 2.0, 0, height], [0, 0, height]])).revolve("Z", 360);
foot - cylinder([0, 0, height - depth], "Z", stud / 2.0, depth + 1.0)
