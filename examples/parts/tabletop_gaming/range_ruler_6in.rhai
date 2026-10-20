// Tabletop range ruler: 6 in (152.4 mm) stick 12 x 3 mm with 1 in (25.4 mm) notches and a 6 mm hang hole
let inches = 6; // [3, 12] Length in inches
let width = 12.0; // [8.0, 20.0] Width (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let length = inches.to_float() * 25.4;
let stick = box_from_corners([0, 0, 0], [length, width, t]);
let s = stick.fillet(2.0, stick.edges("|Z"));
let notches = [];
for i in 1..inches { notches.push(box_from_corners([i.to_float() * 25.4 - 0.5, -1, -1], [i.to_float() * 25.4 + 0.5, 2.5, t + 1.0])); }
s - compound(notches) - cylinder([length - 6.0, width / 2.0 + 1.0, -1], "Z", 2.0, t + 2.0)
