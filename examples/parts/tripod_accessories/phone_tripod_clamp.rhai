// Smartphone tripod clamp: spring jaws 58 to 90 mm, 25 mm wide, 1/4-20 nut pocket 11 mm hex, padded 3 mm lips (body only)
let min_w = 58.0; // [55.0, 70.0] Closed width (mm)
let width = 25.0; // [20.0, 35.0] Clamp width (mm)
let body = box_centered(min_w + 10.0, width, 12.0).translate([0, 0, 6.0]);
let jaws = box_from_corners([-min_w / 2.0 - 5.0, -width / 2.0, 11.99], [-min_w / 2.0, width / 2.0, 30.0]) + box_from_corners([min_w / 2.0, -width / 2.0, 11.99], [min_w / 2.0 + 5.0, width / 2.0, 30.0]);
let lips = box_from_corners([-min_w / 2.0, -width / 2.0, 26.0], [-min_w / 2.0 + 3.0, width / 2.0, 30.0]) + box_from_corners([min_w / 2.0 - 3.0, -width / 2.0, 26.0], [min_w / 2.0 + 0.01, width / 2.0, 30.0]);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([11.0 / 3.0.sqrt() * a.cos(), 11.0 / 3.0.sqrt() * a.sin()]); }
let nut = polygon(pts).to_face().extrude([0, 0, 5.5]).translate([0, 0, -0.01]);
body + jaws + lips - nut - cylinder([0, 0, -1], "Z", 3.3, 14.0)
