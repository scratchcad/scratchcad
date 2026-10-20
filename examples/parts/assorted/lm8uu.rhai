// LM8UU linear ball bearing
let bore = 8.0; // [6.0, 12.0] Bore (mm)
let outer = 15.0; // [12.0, 21.0] Outside diameter (mm)
let length = 24.0; // [19.8, 30.0] Length (mm)
let groove_spacing = 17.5; // [10.0, 20.0] Distance between ring grooves (mm)
let groove_width = 1.1; // [0.8, 1.5] Ring groove width (mm)
let groove_d = 14.3; // [11.0, 20.0] Ring groove diameter (mm)
let body = cylinder(outer / 2.0, length);
for s in [-1, 1] {
    let z = length / 2.0 + s * groove_spacing / 2.0 - groove_width / 2.0;
    body -= cylinder([0, 0, z], "Z", outer / 2.0 + 1, groove_width) - cylinder([0, 0, z - 1], "Z", groove_d / 2.0, groove_width + 2);
}
body = body.chamfer(0.4, "%CIRCLE and (>Z or <Z)");
body - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2)
