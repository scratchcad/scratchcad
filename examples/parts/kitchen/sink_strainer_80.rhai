// Kitchen sink basket strainer: 80 mm dished disc 1.2 mm thick, 8 mm deep, 3 mm holes in four rings, rolled rim, 12 mm centre lift knob 15 mm tall
let diameter = 80.0; // [60.0, 120.0] Strainer diameter (mm)
let dish_depth = 8.0; // [3.0, 20.0] Dish depth (mm)
let thickness = 1.2; // [0.8, 2.5] Sheet thickness (mm)
let hole_diameter = 3.0; // [1.5, 5.0] Hole diameter (mm)
let ring_count = 4; // [2, 6] Rings of holes
let r = diameter / 2.0;
// dish surface: a spherical cap through the rim and the centre depth
let rs = (r * r + dish_depth * dish_depth) / (2.0 * dish_depth);
let cap = sphere([0, 0, rs], rs) & cylinder([0, 0, -1.0], "Z", r, dish_depth + 1.0);
let dish = cap - sphere([0, 0, rs], rs - thickness);
dish = dish + torus(r, thickness).translate([0, 0, dish_depth]);
let knob = cylinder([0, 0, 0.3], "Z", 6.0, 15.0).fillet(2.0, "%CIRCLE and >Z");
dish = dish + knob;
// vertical holes in rings between the knob and the rim
let holes = [];
for k in 0..ring_count {
    let rr = 11.0 + k.to_float() * (r - 17.0) / (ring_count - 1).max(1).to_float();
    let n = (2.0 * PI() * rr / (hole_diameter * 2.2)).floor().to_int();
    for j in 0..n {
        holes.push(cylinder([rr, 0, -2.0], "Z", hole_diameter / 2.0, dish_depth + 4.0).rotate_z(j.to_float() * 360.0 / n.to_float()));
    }
}
dish - compound(holes)
