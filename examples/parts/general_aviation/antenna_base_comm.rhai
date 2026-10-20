// VHF comm antenna base fairing: 90 x 60 mm teardrop 12 mm tall, BNC through-hole 9.7 mm, 4 x #8 holes
let length = 90.0; // [60.0, 120.0] Length (mm)
let width = 60.0; // [40.0, 80.0] Width (mm)
let height = 12.0; // [8.0, 20.0] Height (mm)
let outline = polygon([[-length / 2.0, 0], [-length / 2.0 + 20.0, width / 2.0], [length / 4.0, width / 2.0 * 0.8], [length / 2.0, 0], [length / 4.0, -width / 2.0 * 0.8], [-length / 2.0 + 20.0, -width / 2.0]]).to_face().extrude([0, 0, height]);
let o = outline.fillet(10.0, outline.edges("|Z"));
let top = sphere([0, 0, height - 200.0], 200.0);
let shaped = o & top;
let holes = [];
for p in [[-25.0, 15.0], [-25.0, -15.0], [20.0, 12.0], [20.0, -12.0]] { holes.push(cylinder([p[0], p[1], -1], "Z", 2.1, height + 2.0)); }
shaped - cylinder([0, 0, -1], "Z", 4.85, height + 2.0) - compound(holes)
