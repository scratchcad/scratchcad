// Hexagonal paperweight: 70 mm across flats, 30 mm tall, 3 mm chamfers top and bottom, sealed 48 mm x 12 mm internal cavity to fill with steel shot through a 6 mm plug hole underneath
let af = 70.0; // [40.0, 100.0] Across flats (mm)
let height = 30.0; // [18.0, 45.0] Height (mm)
let chamfer = 3.0; // [1.0, 5.0] Edge chamfer (mm)
let cavity_d = 48.0; // [20.0, 70.0] Shot cavity diameter (mm)
let cavity_h = 12.0; // [6.0, 25.0] Shot cavity height (mm)

let rc = af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = (i * 60.0 + 30.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0]);
}
let w = polygon(pts).to_face().extrude([0, 0, height]);
w = w.chamfer(min(chamfer, height / 4.0), w.edges("|Z"));
w = w.chamfer(min(chamfer, height / 4.0), w.edges(">Z or <Z"));
let cd = min(cavity_d, af - 12.0);
let ch = min(cavity_h, height - 10.0);
w = w - cylinder([0, 0, (height - ch) / 2.0], "Z", cd / 2.0, ch);
w - cylinder([0, 0, -1.0], "Z", 3.0, (height - ch) / 2.0 + 2.0)
