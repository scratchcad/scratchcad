// Triangular gusset plate 80 x 80 mm, 5 mm thick, with a 40 mm lightening hole and 3 bolt holes
let leg = 80.0; // [40.0, 200.0] Leg length (mm)
let thickness = 5.0; // [2.0, 12.0] Thickness (mm)
let hole_d = 8.5; // [4.0, 14.0] Bolt hole (mm)
let plate = polygon([[0, 0], [leg, 0], [0, leg]]).to_face().extrude(thickness).fillet(4.0, "|Z");
plate = plate - cylinder([leg * 0.3, leg * 0.3, -1], "Z", leg * 0.12, thickness + 2.0);
for p in [[leg * 0.75, leg * 0.08], [leg * 0.08, leg * 0.75], [leg * 0.08, leg * 0.08]] { plate -= cylinder([p[0] + 2.0, p[1] + 2.0, -1], "Z", hole_d / 2.0, thickness + 2.0); }
plate
