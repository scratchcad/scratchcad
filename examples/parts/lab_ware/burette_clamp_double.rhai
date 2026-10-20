// Double burette clamp: 70 x 12 x 10 mm body with a 13 mm rod bore, two spring jaws for 8 to 20 mm burettes
let span = 70.0; // [50.0, 100.0] Body length (mm)
let jaw_r = 9.0; // [5.0, 12.0] Jaw inner radius (mm)
let body = box_centered(span, 12.0, 10.0).fillet(2.0, "|Z") - cylinder([0, 0, -6.0], "Z", 6.5, 12.0);
let jaws = [];
for s in [-1.0, 1.0] {
    let c = s * (span / 2.0 + jaw_r);
    let ring = (cylinder([c, 0, -5.0], "Z", jaw_r + 2.0, 10.0) - cylinder([c, 0, -6.0], "Z", jaw_r, 12.0)) - box_centered(jaw_r * 1.2, 4.0 * jaw_r, 12.0).translate([c + s * (jaw_r + 2.0), 0, 0]);
    jaws.push(ring);
}
fuse_all([body] + jaws)
