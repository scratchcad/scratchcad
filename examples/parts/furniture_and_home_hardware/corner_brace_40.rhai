// Steel corner brace 40 x 40 x 16 mm, 2 mm thick, two 4.5 mm holes per leg, pressed stiffening gusset
let leg = 40.0; // [25.0, 100.0] Leg length (mm)
let w = 16.0; // [12.0, 30.0] Width (mm)
let b = box_from_corners([0, 0, 0], [leg, w, 2.0]) + box_from_corners([0, 0, 0], [2.0, w, leg]);
b += polygon([[2, 0, 2], [12, 0, 2], [2, 0, 12]]).to_face().extrude([0, 2.0, 0]).translate([0, w / 2.0 - 1.0, 0]);
for p in [leg * 0.4, leg * 0.8] {
    b -= cylinder([p, w / 2.0, -1], "Z", 2.25, 4.0);
    b -= cylinder([-1, w / 2.0, p], "X", 2.25, 4.0);
}
b
