// Keyhole escutcheon: 30 x 50 mm oval plate 2 mm thick with chamfered edge, 8 mm keyhole with tapered bit slot, two 2 mm pin holes
let w = 30.0; // [20.0, 40.0] Width (mm)
let h = 50.0; // [35.0, 70.0] Height (mm)
let plate = sketch().move_to(-w / 2.0, -h / 2.0 + w / 2.0).arc_to(0, -h / 2.0, w / 2.0, -h / 2.0 + w / 2.0).line_to(w / 2.0, h / 2.0 - w / 2.0).arc_to(0, h / 2.0, -w / 2.0, h / 2.0 - w / 2.0).close().to_face().extrude(2.0).chamfer(0.6, ">Z");
plate -= cylinder([0, 4.0, -1], "Z", 4.0, 4.0) + polygon([[-1.5, 4.0], [1.5, 4.0], [2.5, -9.0], [-2.5, -9.0]]).to_face().extrude(4.0).translate([0, 0, -1]);
for y in [-h / 2.0 + 6.0, h / 2.0 - 6.0] { plate -= cylinder([0, y, -1], "Z", 1.0, 4.0); }
plate
