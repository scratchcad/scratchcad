// Smart thermostat trim backplate: 110 mm round 3 mm, 60 x 60 mm wire window, 4 slots on 83.5 mm junction box pitch, bubble level pocket
let d = 110.0; // [90.0, 150.0] Plate diameter (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let window = 50.0; // [30.0, 70.0] Wire window (mm)
let plate = cylinder(d / 2.0, t);
let p = plate.chamfer(1.0, plate.edges(">Z"));
let slots = [];
for k in 0..4 { slots.push(box_centered(8.0, 3.6, t + 2.0).translate([41.75, 0, t / 2.0]).rotate_z(k.to_float() * 90.0)); }
let level = box_centered(20.0, 6.0, 2.0).translate([0, -d / 2.0 + 12.0, t]);
p - box_centered(window, window, t * 3.0) - compound(slots) - level
