// Split lever spindle: 8 mm square bar 100 mm long with 0.5 mm edge chamfers and four M4 grub-screw tapped holes (3.3 mm) for the lever set screws
let length = 100.0; // [70.0, 140.0] Spindle length (mm)
let size = 8.0; // [7.0, 9.0] Square size (mm)
let s = box_centered(size, size, length).translate([0, 0, length / 2.0]);
let s = s.chamfer(0.5, s.edges("|Z"));
let holes = [];
for z in [8.0, 16.0, length - 16.0, length - 8.0] { holes.push(cylinder([-size, 0, z], "X", 1.65, 2.0 * size)); }
s - fuse_all(holes)
