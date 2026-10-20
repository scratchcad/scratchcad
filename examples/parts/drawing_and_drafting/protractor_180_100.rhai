// 180 degree protractor, 100 mm: 2 mm thick, 15 mm band, 1 degree ticks, 5 and 10 degree marks longer
let radius = 50.0; // [40.0, 100.0] Outer radius (mm)
let band = 15.0; // [10.0, 25.0] Band width (mm)
let thickness = 2.0; // [1.5, 3.0] Thickness (mm)
let disc = cylinder(radius, thickness) & box_from_corners([-radius - 1.0, -8.0, -1], [radius + 1.0, radius + 1.0, thickness + 1.0]);
let window = cylinder([0, 0, -1], "Z", radius - band, thickness + 2.0) & box_from_corners([-radius, 2.0, -2], [radius, radius, thickness + 2.0]);
let ticks = [];
for d in 0..=180 {
    let len = if d % 10 == 0 { 6.0 } else if d % 5 == 0 { 4.0 } else { 2.5 };
    ticks.push(box_from_corners([radius - len, -0.15, thickness - 0.4], [radius + 0.5, 0.15, thickness + 1.0]).rotate_z(d.to_float()));
}
disc - window - compound(ticks) - cylinder([0, 0, -1], "Z", 0.6, thickness + 2.0)
