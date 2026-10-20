// Dog treat puzzle drum: 75 mm 14-sided drum 70 mm tall, hollow with 3 mm walls, a 15 mm treat hole through both sides and a 30 mm fill port in the top
let dia = 75.0; // [60.0, 100.0] Toy diameter (mm)
let holes = 15.0; // [10.0, 22.0] Treat hole diameter (mm)
const wall = 3.0;
let pts = [];
for i in 0..14 { let a = i.to_float() * 2.0 * PI() / 14.0; pts.push([dia / 2.0 * cos(a), dia / 2.0 * sin(a), 0]); }
let drum = face(polygon(pts)).extrude([0, 0, 70.0]);
let inner = cylinder([0, 0, wall], "Z", dia / 2.0 - wall - 1.0, 70.0 - 2.0 * wall);
drum - inner - cylinder([-dia, 0, 25.0], "X", holes / 2.0, 2.0 * dia) - cylinder([0, 0, 70.0 - wall - 1.0], "Z", 15.0, wall + 2.0)
