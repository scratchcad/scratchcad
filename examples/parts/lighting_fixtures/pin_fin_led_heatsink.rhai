// Pin-fin LED heatsink: 50 mm round base 4 mm, 61 pins 3 mm diameter 20 mm tall on 5.5 mm hex grid, 2 M3 holes
let diameter = 50.0; // [30.0, 80.0] Base diameter (mm)
let base_t = 4.0; // [2.0, 6.0] Base thickness (mm)
let pin_d = 3.0; // [2.0, 5.0] Pin diameter (mm)
let pin_h = 20.0; // [10.0, 35.0] Pin height (mm)
let pitch = 5.5; // [4.0, 8.0] Pin pitch (mm)
let base = cylinder(diameter / 2.0, base_t);
let pins = [];
let n = (diameter / 2.0 / pitch).floor().to_int();
for i in -n..=n { for j in -n..=n {
    let x = i.to_float() * pitch + (j % 2).abs().to_float() * pitch / 2.0;
    let y = j.to_float() * pitch * 0.866;
    if (x * x + y * y).sqrt() < diameter / 2.0 - pin_d && (x - 12.0).abs() + y.abs() > 5.0 && (x + 12.0).abs() + y.abs() > 5.0 { pins.push(cylinder([x, y, base_t - 0.01], "Z", pin_d / 2.0, pin_h)); }
} }
base + compound(pins) - cylinder([12.0, 0, -1], "Z", 1.6, base_t + 2.0) - cylinder([-12.0, 0, -1], "Z", 1.6, base_t + 2.0)
