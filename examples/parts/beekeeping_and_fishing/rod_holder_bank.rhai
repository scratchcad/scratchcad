// Bank rod holder: 450 mm spike 12 mm, Y-rest 60 mm wide with 25 mm rubber-lined cradle
let spike = 450.0; // [250.0, 600.0] Spike length (mm)
let rod = 12.0; // [8.0, 16.0] Spike diameter (mm)
let rest_w = 60.0; // [40.0, 90.0] Rest width (mm)
let s = cylinder(rod / 2.0, spike) & (cone(0.5, rod, 40.0) + cylinder([0, 0, 39.99], "Z", rod, spike));
let y = polygon([[-rest_w / 2.0, 0, 0], [-rest_w / 2.0 + 8.0, 0, 0], [0, 0, -rest_w * 0.6 + 8.0], [rest_w / 2.0 - 8.0, 0, 0], [rest_w / 2.0, 0, 0], [6.0, 0, -rest_w * 0.6], [-6.0, 0, -rest_w * 0.6]]).to_face().extrude([0, 8.0, 0]).translate([0, -4.0, spike + rest_w * 0.6]);
s + y
