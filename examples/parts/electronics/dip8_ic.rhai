// DIP-8 IC: 9.4 x 6.35 x 3.3 mm body with pin-1 notch and dimple, 8 gull-ish legs at 2.54 mm pitch, 7.62 mm row spacing
let pins = 8; // [4, 40] Pins
let row = 7.62; // [7.62, 15.24] Row spacing (mm)
let width = 6.35; // [6.0, 14.0] Body width (mm)
let height = 3.3; // [2.5, 4.5] Body height (mm)
let per_side = pins / 2;
let length = per_side.to_float() * 2.54 - 0.75;
let body = box_centered(length, width, height).translate([0, 0, 0.5 + height / 2.0]).chamfer(0.2, "|X or |Y");
body = body - cylinder([-length / 2.0, 0, 0.5 + height - 1.0], "Z", 0.8, 2.0) - cylinder([-length / 2.0 + 1.5, -width / 2.0 + 1.5, 0.5 + height - 0.2], "Z", 0.5, 1.0);
let legs = [];
for i in 0..per_side { for s in [-1, 1] {
    let x = -(per_side - 1).to_float() * 1.27 + i.to_float() * 2.54;
    legs.push(box_centered(1.5, (row - width) / 2.0 + 0.3, 0.25).translate([x, s * (width / 2.0 + (row - width) / 4.0 - 0.1), 0.5 + height * 0.4]));
    legs.push(box_centered(0.5, 0.25, 4.0).translate([x, s * row / 2.0, -1.0]) + box_centered(1.5, 0.25, 1.4).translate([x, s * row / 2.0, 0.3 + height * 0.4 - 0.6]));
} }
fuse_all([body] + legs)
