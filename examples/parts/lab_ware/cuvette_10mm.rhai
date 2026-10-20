// 10 mm path quartz cuvette: 12.5 x 12.5 x 45 mm, 10 x 10 mm chamber from 2 mm above the base, frosted grip ribs on two sides
let h = 45.0; // [30.0, 50.0] Height (mm)
let c = box_centered(12.5, 12.5, h).translate([0, 0, h / 2.0]) - box_centered(10.0, 10.0, h).translate([0, 0, h / 2.0 + 2.0]);
for x in [-6.4, 6.4] { c += box_centered(0.3, 8.0, h - 15.0).translate([x, 0, h / 2.0 + 5.0]); }
c
