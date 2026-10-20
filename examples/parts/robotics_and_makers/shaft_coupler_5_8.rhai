// Rigid clamping shaft coupler 5 mm to 8 mm (stepper to lead screw): 19 mm diameter, 25 mm long, 1 mm clamp slit in each half on opposite sides, a tangential M3 clamp screw across each slit
let bore_a = 5.0; // [2.0, 10.0] Motor-side bore (mm)
let bore_b = 8.0; // [2.0, 12.0] Screw-side bore (mm)
let dia = 19.0; // [12.0, 30.0] Outside diameter (mm)
let length = 25.0; // [16.0, 40.0] Length (mm)
let r = dia / 2.0;
let ba = min(bore_a, dia - 8.0);
let bb = min(bore_b, dia - 8.0);
let half = length / 2.0;
let c = cylinder(r, length).chamfer(0.6, ">Z or <Z");
c -= cylinder([0, 0, -1], "Z", ba / 2.0, half + 1.0) + cylinder([0, 0, half - 0.01], "Z", bb / 2.0, half + 1.0);
c -= box_from_corners([-0.5, 0, -1.0], [0.5, r + 1.0, half - 1.0]);
c -= box_from_corners([-0.5, -r - 1.0, half + 1.0], [0.5, 0, length + 1.0]);
c -= box_from_corners([-r - 1.0, -0.6, half - 1.0], [r + 1.0, r + 1.0, half - 0.2]) - cylinder([0, 0, half - 2.0], "Z", max(ba, bb) / 2.0 + 2.5, 3.0);
let ys = (r + max(ba, bb) / 2.0) / 2.0 + 0.3;
c -= cylinder([-r - 1.0, ys, half / 2.0], "X", 1.6, dia + 2.0) + cylinder([-r - 1.0, -ys, half + half / 2.0], "X", 1.6, dia + 2.0);
c -= cylinder([-r - 1.0, ys, half / 2.0], "X", 2.8, 4.0) + cylinder([-r - 1.0, -ys, half + half / 2.0], "X", 2.8, 4.0);
c
