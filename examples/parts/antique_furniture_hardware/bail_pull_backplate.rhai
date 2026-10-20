// Chippendale bail pull backplate: 90 x 45 mm batwing outline 1.5 mm, 2 post holes 4 mm on 76 mm (3 in) centres
let width = 90.0; // [70.0, 130.0] Plate width (mm)
let height = 45.0; // [30.0, 60.0] Plate height (mm)
let centers = 76.2; // [64.0, 101.6] Post centres (mm)
let t = 1.5; // [1.0, 3.0] Thickness (mm)
let pts = [[-width / 2.0, 0], [-width * 0.42, height * 0.4], [-width * 0.3, height / 2.0], [-width * 0.15, height * 0.35], [0, height / 2.0], [width * 0.15, height * 0.35], [width * 0.3, height / 2.0], [width * 0.42, height * 0.4], [width / 2.0, 0], [width * 0.42, -height * 0.4], [width * 0.3, -height / 2.0], [width * 0.15, -height * 0.35], [0, -height / 2.0], [-width * 0.15, -height * 0.35], [-width * 0.3, -height / 2.0], [-width * 0.42, -height * 0.4]];
let plate = polygon(pts).to_face().extrude([0, 0, t]);
plate - cylinder([-centers / 2.0, 0, -1], "Z", 2.0, t + 2.0) - cylinder([centers / 2.0, 0, -1], "Z", 2.0, t + 2.0)
