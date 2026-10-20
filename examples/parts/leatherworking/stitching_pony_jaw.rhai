// Stitching pony jaw pair: 150 mm tall, 60 mm wide jaws tapering to 6 mm lips, 8 mm thick, M8 clamp bolt hole (two solids)
let height = 150.0; // [100.0, 200.0] Jaw height (mm)
let width = 60.0; // [40.0, 90.0] Jaw width (mm)
let t = 8.0; // [6.0, 12.0] Jaw thickness (mm)
let jaw = polygon([[0, 0, 0], [0, 0, height], [0, 6.0, height], [0, 20.0, height * 0.4], [0, 20.0, 0]]).to_face().extrude([width, 0, 0]);
let j = jaw - cylinder([width / 2.0, -1, height * 0.3], "Y", 4.25, 30.0);
compound([j, j.mirror([0, 1, 0]).translate([0, -2.0, 0])])
