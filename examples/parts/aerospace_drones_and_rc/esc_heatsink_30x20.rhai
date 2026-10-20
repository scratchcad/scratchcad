// ESC heatsink: 30 x 20 x 2 mm base with nine 1 mm fins 10 mm tall at 3.5 mm pitch
let fins = 9; // [5, 12] Fins
let fin_h = 10.0; // [5.0, 20.0] Fin height (mm)
let parts = [box_centered(30.0, 20.0, 2.0).translate([0, 0, 1.0])];
for k in 0..fins { parts.push(box_centered(1.0, 20.0, fin_h).translate([(k.to_float() - (fins - 1).to_float() / 2.0) * 3.5, 0, 2.0 + fin_h / 2.0 - 0.01])); }
fuse_all(parts)
