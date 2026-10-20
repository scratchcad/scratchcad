// Pin spanner for adjustable bottom bracket cups: 160 x 20 x 4 mm handle, 34 mm round head with two 2.3 mm pins 4 mm tall 26 mm apart, 6 mm hang hole
let pin_spacing = 26.0; // [20.0, 30.0] Pin spacing (mm)
let pin_d = 2.3; // [1.8, 3.0] Pin diameter (mm)
let pin_h = 4.0; // [2.5, 6.0] Pin height (mm)
let length = 160.0; // [120.0, 220.0] Handle length (mm)
const width = 20.0;
const thickness = 4.0;
let head_r = pin_spacing / 2.0 + 4.0;
let body = fuse_all([
    cylinder(head_r, thickness),
    box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]),
    cylinder([length, 0, 0], "Z", width / 2.0, thickness),
]);
let body = body - cylinder([length, 0, -1.0], "Z", 3.0, thickness + 2.0);
let pins = [];
for s in [-1.0, 1.0] {
    pins.push(cylinder([0, s * pin_spacing / 2.0, thickness - 0.5], "Z", pin_d / 2.0, pin_h + 0.5));
}
body + fuse_all(pins)
