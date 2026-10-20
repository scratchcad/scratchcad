// TO-220 extruded heat sink: 25 x 25 mm base 3 mm thick, 6 fins 1.5 mm x 22 mm tall, 25 mm long, M3 mounting hole
let width = 25.0; // [15.0, 60.0] Width (mm)
let length = 25.0; // [15.0, 60.0] Length (mm)
let base_t = 3.0; // [2.0, 6.0] Base thickness (mm)
let fins = 6; // [3, 12] Fins
let fin_t = 1.5; // [0.8, 3.0] Fin thickness (mm)
let fin_h = 22.0; // [8.0, 40.0] Fin height (mm)
let base = box_centered(width, length, base_t).translate([0, 0, base_t / 2.0]);
let pitch = (width - fin_t) / (fins - 1).to_float();
let parts = [base];
for i in 0..fins { parts.push(box_centered(fin_t, length, fin_h).translate([-width / 2.0 + fin_t / 2.0 + i.to_float() * pitch, 0, base_t + fin_h / 2.0 - 0.01])); }
fuse_all(parts) - cylinder([0, length * 0.25, -1], "Z", 1.6, base_t + fin_h + 2.0)
