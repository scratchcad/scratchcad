// Saxophone thumb rest cushion: 22 x 14 mm pad, 8 mm tall, curved top, 9 mm snap socket for the hook
let length = 22.0; // [16.0, 30.0] Length (mm)
let width = 14.0; // [10.0, 20.0] Width (mm)
let height = 8.0; // [5.0, 12.0] Height (mm)
let pad = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let top = cylinder([-length, 0, -20.0 + height], "X", 22.0, length * 2.0);
let p = pad & top;
let pp = p.fillet(2.0, p.edges("|Z"));
pp - box_centered(9.0, 6.0, 5.0).translate([0, 0, 2.0])
