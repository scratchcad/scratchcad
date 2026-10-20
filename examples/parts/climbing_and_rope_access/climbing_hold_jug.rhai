// Bolt-on climbing hold jug: 110 x 70 mm footprint, 45 mm tall with an undercut lip 20 mm deep, 10.5 mm bolt hole with a 24 mm countersink for an M10 socket cap screw
let length = 110.0; // [80.0, 150.0] Hold length (mm)
let height = 45.0; // [30.0, 60.0] Hold height (mm)
const width = 70.0;
let base = face(polygon([[-length / 2.0, -width / 2.0, 0], [length / 2.0, -width / 2.0, 0], [length / 2.0 - 10.0, width / 2.0, 0], [-length / 2.0 + 10.0, width / 2.0, 0]]));
let top = face(polygon([[-length / 2.0 + 15.0, -width / 2.0 + 5.0, height], [length / 2.0 - 15.0, -width / 2.0 + 5.0, height], [length / 2.0 - 25.0, width / 2.0 - 20.0, height], [-length / 2.0 + 25.0, width / 2.0 - 20.0, height]]));
let h = loft([base.wires()[0], top.wires()[0]], true);
let pocket = box_from_corners([-length / 2.0 + 20.0, -width / 2.0 - 1.0, 8.0], [length / 2.0 - 20.0, -width / 2.0 + 20.0, height - 12.0]);
let bolt = cylinder([0, 5.0, -1.0], "Z", 5.25, height + 2.0) + cylinder([0, 5.0, 25.0], "Z", 12.0, height);
h - pocket - bolt
