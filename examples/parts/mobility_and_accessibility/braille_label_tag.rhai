// Braille label tag: 60 x 22 x 2 mm tag reading "ON" in Grade 1 braille, 1.5 mm dots 0.6 mm high at 2.5 mm dot pitch and 6.2 mm cell pitch, 4 mm hanging hole, orientation notch at top-left corner
// # Tag
let length = 60.0; // [40.0, 90.0] Tag length (mm)
let width = 22.0; // [16.0, 30.0] Tag width (mm)
let thickness = 2.0; // [1.2, 3.0] Tag thickness (mm)
// # Dots
let dot_d = 1.5; // [1.2, 1.8] Dot base diameter (mm)
let dot_h = 0.6; // [0.4, 0.9] Dot height (mm)
const dot_pitch = 2.5;
const cell_pitch = 6.2;
// cells as dot numbers 1-6: O = 1,3,5 ; N = 1,3,4,5
let cells = [[1, 3, 5], [1, 3, 4, 5]];
let tag = box_from_corners([0, 0, 0], [length, width, thickness]).fillet(3.0, "|Z");
let dots = [];
const x0 = 12.0;
let y0 = width / 2.0 + dot_pitch;
for c in 0..cells.len() {
    for n in cells[c] {
        let col = if n > 3 { 1.0 } else { 0.0 };
        let row = ((n - 1) % 3).to_float();
        let x = x0 + c.to_float() * cell_pitch + col * dot_pitch;
        let y = y0 - row * dot_pitch;
        dots.push(cone(dot_d / 2.0, dot_d / 4.0, dot_h).translate([x, y, thickness - 0.01]));
    }
}
let hole = cylinder([length - 6.0, width / 2.0, -1.0], "Z", 2.0, thickness + 2.0);
let notch = polygon([[-1.0, width - 5.0], [5.0, width + 1.0], [-1.0, width + 1.0]]).extrude([0, 0, thickness + 2.0]).translate([0, 0, -1.0]);
tag + compound(dots) - hole - notch
