// Heat-set insert pressing guide: 30 x 30 x 25 mm block with a 6 mm tip bore and a 10 mm countersink alignment cone
let size = 30.0; // [20.0, 40.0] Block size (mm)
let height = 25.0; // [15.0, 40.0] Height (mm)
let bore = 6.0; // [4.0, 10.0] Tip bore (mm)
let block = box_centered(size, size, height).translate([0, 0, height / 2.0]);
let b = block.fillet(3.0, block.edges("|Z"));
b - cylinder([0, 0, -1], "Z", bore / 2.0, height + 2.0) - cone(bore / 2.0, 5.0, 4.0).translate([0, 0, height - 3.99]) - box_from_corners([-size, -2.0, -1], [0, 2.0, 6.0])
