// Table number card stand: 60 x 40 mm weighted base 10 mm thick with 3 mm edge chamfer and a 2 mm card slot 8 mm deep across the top, tilted 10 degrees back
let width = 60.0; // [40.0, 100.0] Base width (mm)
let slot = 2.0; // [0.8, 4.0] Card slot width (mm)
const h = 10.0;
let b = box_centered(width, 40.0, h).translate([0, 0, h / 2.0]);
let b = b.chamfer(3.0, b.edges(">Z"));
b - box_centered(width - 10.0, slot, 20.0).rotate_x(-10.0).translate([0, 0, h])
