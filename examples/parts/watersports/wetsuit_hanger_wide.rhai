// Wide-shoulder wetsuit hanger: 430 mm wide, 40 mm deep shoulders, 6 mm swivel hook rod, drain slots
let width = 430.0; // [350.0, 500.0] Hanger width (mm)
let depth = 40.0; // [25.0, 60.0] Shoulder depth (mm)
let t = 8.0; // [5.0, 12.0] Body thickness (mm)
let body = polygon([[-width / 2.0, 0], [width / 2.0, 0], [width / 2.0 - 20.0, 60.0], [30.0, 110.0], [-30.0, 110.0], [-width / 2.0 + 20.0, 60.0]]).to_face().extrude([0, 0, depth]).translate([0, 0, -depth / 2.0]);
let b = body.fillet(15.0, body.edges("|Z"));
let hollow = polygon([[-width / 2.0 + 30.0, 12.0], [width / 2.0 - 30.0, 12.0], [width / 2.0 - 45.0, 55.0], [20.0, 95.0], [-20.0, 95.0], [-width / 2.0 + 45.0, 55.0]]).to_face().extrude([0, 0, depth + 2.0]).translate([0, 0, -depth / 2.0 - 1.0]);
let slots = [];
for k in -5..=5 { slots.push(box_centered(4.0, 7.0, depth + 2.0).translate([k.to_float() * 35.0, 6.0, 0])); }
let hk = (cylinder([0, 175.0, 0], "Z", 20.0, 6.0) - cylinder([0, 175.0, -1], "Z", 14.0, 8.0) - box_from_corners([-25, 160, -1], [0, 175.0, 8])).translate([0, 0, -3.0]);
b - hollow - compound(slots) + cylinder([0, 109.0, 0], "Y", 3.0, 52.0) + hk
