// Pie crust shield: fits 230 mm (9 in) pie dishes, 60 mm wide ring 1 mm sloped 20 degrees, 160 mm opening
let dish = 240.0; // [200.0, 300.0] Outer diameter (mm)
let opening = 160.0; // [120.0, 220.0] Center opening (mm)
let t = 1.0; // [0.6, 2.0] Thickness (mm)
let drop = 15.0; // [5.0, 30.0] Edge drop (mm)
let outer = cone(dish / 2.0, opening / 2.0, drop) - cone(dish / 2.0 - t * 1.4, opening / 2.0 - t * 1.4, drop).translate([0, 0, -t]);
outer & cylinder([0, 0, -1], "Z", dish / 2.0, drop + 2.0) - cylinder([0, 0, -1], "Z", opening / 2.0 - 2.0, drop + 2.0)
