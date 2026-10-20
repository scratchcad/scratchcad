// M3 brass heat-set insert, flanged
let length = 5.7; // [3.0, 8.0] Length (mm)
let body_d = 4.6; // [4.0, 5.5] Knurled body diameter (mm)
let flange_d = 5.5; // [4.5, 7.0] Flange diameter (mm)
let flange_t = 0.5; // [0.3, 1.0] Flange thickness (mm)
let knurls = 12; // [6, 24] Number of knurl ridges
let r = body_d / 2.0;
let insert = cylinder(flange_d / 2.0, flange_t) + cylinder([0, 0, flange_t - 0.01], "Z", r - 0.25, length - flange_t + 0.01);
// two bands of diagonal knurls, opposite hands, with a plain groove between them
let band_h = (length - flange_t - 0.8) / 2.0;
let ridge = box_centered(0.7, 0.7, band_h * 1.6).rotate_z(45).translate([r - 0.3, 0, 0]);
let bands = [];
for b in 0..2 {
    let z = flange_t + band_h / 2.0 + b.to_float() * (band_h + 0.8);
    let lean = if b == 0 { 25.0 } else { -25.0 };
    let band = cylinder([0, 0, z - band_h / 2.0], "Z", r + 0.1, band_h);
    let ridges = [];
    for i in 0..knurls { ridges.push(ridge.rotate_x(lean).translate([0, 0, z]).rotate_z(i * 360 / knurls)); }
    bands.push(fuse_all(ridges) & band);
}
insert = fuse_all([insert] + bands);
insert - cylinder([0, 0, -1], "Z", 1.25, length + 2.0)
