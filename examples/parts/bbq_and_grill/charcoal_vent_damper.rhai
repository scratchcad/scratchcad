// Kettle grill bottom vent damper: 120 mm 3-blade rotating plate 1.5 mm, 3 x 40 degree vanes, 8 mm pivot, handle tab 20 mm
let diameter = 120.0; // [80.0, 160.0] Damper diameter (mm)
let t = 1.5; // [1.0, 3.0] Plate thickness (mm)
let vane = 40.0; // [25.0, 60.0] Opening angle per vane (degrees)
let plate = cylinder(diameter / 2.0, t);
let opens = [];
for k in 0..3 {
    let pts = [[0.0, 0.0]];
    for i in 0..=8 { let a = (k.to_float() * 120.0 + vane * i.to_float() / 8.0) * PI() / 180.0; pts.push([(diameter / 2.0 - 8.0) * a.cos(), (diameter / 2.0 - 8.0) * a.sin()]); }
    opens.push(polygon(pts).to_face().extrude([0, 0, t + 2.0]).translate([0, 0, -1.0]) - cylinder([0, 0, -2], "Z", 15.0, t + 4.0));
}
let tab = box_from_corners([diameter / 2.0 - 2.0, -6.0, 0], [diameter / 2.0 + 20.0, 6.0, t]);
plate - compound(opens) + tab - cylinder([0, 0, -1], "Z", 4.0, t + 2.0)
