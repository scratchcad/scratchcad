// Curtain track end stop: fits 20 x 15 mm track, 25 x 18 x 12 mm block, M4 grub screw
let w = 20.0; // [12.0, 30.0] Track width (mm)
let h = 15.0; // [8.0, 25.0] Track height (mm)
let block = box_centered(w + 5.0, 12.0, h + 3.0).translate([0, 0, (h + 3.0) / 2.0]);
let b = block.fillet(2.0, block.edges("|Y and >Z"));
let channel = box_from_corners([-w / 2.0 - 0.2, -7.0, 2.0], [w / 2.0 + 0.2, 7.0, h]) + box_from_corners([-w / 2.0 + 2.0, -7.0, -1.0], [w / 2.0 - 2.0, 7.0, 2.01]);
b - channel - cylinder([0, 0, h - 1.0], "Z", 1.7, 10.0)
