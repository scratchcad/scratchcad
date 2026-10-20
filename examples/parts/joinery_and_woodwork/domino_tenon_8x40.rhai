// Festool-style loose tenon 8 x 22 x 40 mm: stadium section, fluted faces, chamfered ends
let t = 8.0; // [4.0, 14.0] Thickness (mm)
let width = 22.0; // [17.0, 28.0] Width (mm)
let length = 40.0; // [20.0, 140.0] Length (mm)
let body = box_centered(width, t, length).translate([0, 0, length / 2.0]);
let b = body.fillet(t / 2.0 - 0.01, body.edges("|Z"));
let flutes = [];
for x in [-6.0, 0.0, 6.0] { for s in [-1.0, 1.0] { flutes.push(cylinder([x, s * (t / 2.0 + 0.6), 2.0], "Z", 1.0, length - 4.0)); } }
let c = b - compound(flutes);
c.chamfer(0.8, c.edges("%LINE and (>Z or <Z)"))
