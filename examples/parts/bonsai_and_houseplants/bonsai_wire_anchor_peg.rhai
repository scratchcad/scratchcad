// Bonsai wire anchor peg: 60 mm tapered ground peg 8 mm square at the top, with a 3 mm wire eye and a 12 mm head pad
let length = 60.0; // [40.0, 100.0] Peg length (mm)
let size = 8.0; // [6.0, 12.0] Peg section (mm)
let peg = loft([rect(plane([0, 0, 0], [0, 0, 1]), 2.0, 2.0), rect(plane([0, 0, length], [0, 0, 1]), size, size)], true);
let head = box_centered(12.0, 12.0, 4.0).translate([0, 0, length + 2.0 - 0.01]);
peg + head - cylinder([-10.0, 0, length - 6.0], "X", 1.5, 20.0)
