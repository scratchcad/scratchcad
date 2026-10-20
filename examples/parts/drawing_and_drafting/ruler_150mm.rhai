// 150 mm steel-pattern ruler: 160 x 18 x 1 mm, mm graduations, 5 and 10 mm longer, hang hole
let length = 150.0; // [100.0, 300.0] Scale length (mm)
let width = 18.0; // [12.0, 30.0] Width (mm)
let thickness = 1.0; // [0.5, 3.0] Thickness (mm)
let blank = box_from_corners([-5.0, 0, 0], [length + 5.0, width, thickness]);
let b = blank.fillet(3.0, blank.edges("|Z and >X"));
let ticks = [];
let n = length.to_int();
for i in 0..=n {
    let h = if i % 10 == 0 { 6.0 } else if i % 5 == 0 { 4.5 } else { 3.0 };
    ticks.push(box_from_corners([i.to_float() - 0.1, width - h, thickness - 0.2], [i.to_float() + 0.1, width + 1.0, thickness + 1.0]));
}
b - compound(ticks) - cylinder([length, width / 2.0 - 2.0, -1], "Z", 2.5, thickness + 2.0)
