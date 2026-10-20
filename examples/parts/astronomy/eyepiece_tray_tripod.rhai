// Tripod eyepiece tray: 6 mm triangular plate 200 mm across the legs with three 32 mm (1.25 inch) and three 25 mm (0.965 inch) eyepiece holes and a 10 mm centre bolt hole
let span = 200.0; // [170.0, 260.0] Leg-to-leg circle diameter (mm)
const t = 6.0;
let r = span / 2.0;
let pts = [];
for i in 0..3 { let a = (90.0 + 120.0 * i.to_float()) * PI() / 180.0; pts.push([r * cos(a), r * sin(a), 0]); }
let plate = face(polygon(pts)).extrude([0, 0, t]);
let plate = plate.fillet(10.0, plate.edges("|Z"));
let holes = [cylinder([0, 0, -1.0], "Z", 5.2, t + 2.0)];
for i in 0..3 {
    let a = (90.0 + 120.0 * i.to_float()) * PI() / 180.0;
    let b = a + PI() / 3.0;
    holes.push(cylinder([0.55 * r * cos(a), 0.55 * r * sin(a), -1.0], "Z", 16.0, t + 2.0));
    holes.push(cylinder([0.3 * r * cos(b), 0.3 * r * sin(b), -1.0], "Z", 12.5, t + 2.0));
}
plate - fuse_all(holes)
