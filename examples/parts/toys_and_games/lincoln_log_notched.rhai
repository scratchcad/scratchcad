// Toy building log: 19 mm diameter 128 mm long with two saddle notches 13 mm from each end on opposite sides
let len = 128.0; // [64.0, 256.0] Length (mm)
let d = 19.0; // [12.0, 30.0] Diameter (mm)
let r = d / 2.0;
let log = cylinder([0, 0, 0], "X", r, len).chamfer(1.0, "%CIRCLE");
for x in [13.0, len - 13.0] {
    log -= cylinder([x, -r - 1.0, -r - r * 0.5], "Y", r, d + 2.0);
    log -= cylinder([x, -r - 1.0, r + r * 0.5], "Y", r, d + 2.0);
}
log
