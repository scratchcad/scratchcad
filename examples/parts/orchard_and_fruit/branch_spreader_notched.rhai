// Fruit tree branch spreader: 150 mm bar 8 x 8 mm with V notches 6 mm deep at both ends to sit on branches, and a center grip hole 5 mm
let length = 150.0; // [80.0, 300.0] Spreader length (mm)
let size = 8.0; // [6.0, 12.0] Bar section (mm)
let b = box_centered(length, size, size).translate([0, 0, size / 2.0]);
let notches = [];
for sx in [-1.0, 1.0] { notches.push(face(polygon([[sx * (length / 2.0 + 1.0), -size, size / 2.0 - 3.0], [sx * (length / 2.0 - 6.0), -size, size / 2.0], [sx * (length / 2.0 + 1.0), -size, size / 2.0 + 3.0]])).extrude([0, 2.0 * size, 0])); }
b - fuse_all(notches) - cylinder([0, 0, -1.0], "Z", 2.5, size + 2.0)
