// Skate tool socket bar: 110 mm bar 20 mm square with 9/16 inch (14.3 mm) kingpin, 1/2 inch (12.7 mm) axle and 3/8 inch (9.5 mm) mounting nut hex sockets 12 mm deep
let length = 110.0; // [90.0, 140.0] Bar length (mm)
let depth = 12.0; // [8.0, 16.0] Socket depth (mm)
const s = 20.0;
fn hex(af, x, d, top) {
    let r = af / 2.0 / cos(PI() / 6.0) + 0.15;
    let p = [];
    for i in 0..6 { let a = i.to_float() * PI() / 3.0; p.push([x + r * cos(a), r * sin(a), 0]); }
    face(polygon(p)).extrude([0, 0, d + 1.0]).translate([0, 0, top - d])
}
let bar = box_from_corners([0, -s / 2.0, 0], [length, s / 2.0, s]);
let bar = bar.chamfer(1.0, bar.edges("|X"));
bar - hex(14.3, 15.0, depth, s) - hex(12.7, length / 2.0, depth, s) - hex(9.5, length - 13.0, depth, s) - cylinder([length / 2.0, -s, s / 2.0], "Y", 3.0, 2.0 * s)
