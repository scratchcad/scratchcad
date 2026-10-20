// Flat corner brace (L-plate) 50 x 50 mm, 12 mm wide, 2 mm thick, four countersunk 4 mm holes
let leg = 50.0; // [20.0, 150.0] Leg length (mm)
let width = 12.0; // [8.0, 30.0] Width (mm)
let thickness = 2.0; // [1.0, 5.0] Thickness (mm)
let plate = polygon([[0, 0], [leg, 0], [leg, width], [width, width], [width, leg], [0, leg]]).to_face().extrude(thickness);
plate = plate.fillet(width * 0.4, "|Z and (>X or >Y)");
for p in [[width / 2.0, width / 2.0], [leg - width / 2.0, width / 2.0], [width / 2.0, leg - width / 2.0], [leg * 0.55, width / 2.0], [width / 2.0, leg * 0.55]] {
    plate -= cylinder([p[0], p[1], -1], "Z", 2.0, thickness + 2.0) + cone(2.0, 4.0, 2.0).translate([p[0], p[1], thickness - 2.0 + 0.01]);
}
plate
