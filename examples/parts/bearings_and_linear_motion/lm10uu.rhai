// LM10UU linear bearing: 10 mm bore, 19 mm OD, 29 mm long, two ring grooves 22 mm apart
let bore = 10.0; // [6.0, 20.0] Bore (mm)
let outer = 19.0; // [12.0, 32.0] Outside diameter (mm)
let length = 29.0; // [19.0, 45.0] Length (mm)
let groove_spacing = 22.0; // [12.0, 35.0] Groove spacing (mm)
let body = cylinder(outer / 2.0, length);
for s in [-1, 1] {
    let z = length / 2.0 + s * groove_spacing / 2.0;
    body -= cylinder([0, 0, z - 0.65], "Z", outer / 2.0 + 1, 1.3) - cylinder([0, 0, z - 1.0], "Z", outer / 2.0 - 0.6, 2.0);
}
body.chamfer(0.5, "%CIRCLE and (>Z or <Z)") - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0)
