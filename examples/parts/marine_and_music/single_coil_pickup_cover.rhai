// Single-coil pickup cover: 85 x 18 mm, 16 mm tall, 1 mm wall, six 5 mm pole-piece holes on 10.4 mm spacing, rounded ends
let len = 85.0; // [70.0, 90.0] Length (mm)
let w = 18.0; // [14.0, 22.0] Width (mm)
let h = 16.0; // [12.0, 20.0] Height (mm)
let outer = box_centered(len - w, w, h) + cylinder([-(len - w) / 2.0, 0, -h / 2.0], "Z", w / 2.0, h) + cylinder([(len - w) / 2.0, 0, -h / 2.0], "Z", w / 2.0, h);
let inner = box_centered(len - w, w - 2.0, h) + cylinder([-(len - w) / 2.0, 0, -h / 2.0 - 1.0], "Z", w / 2.0 - 1.0, h) + cylinder([(len - w) / 2.0, 0, -h / 2.0 - 1.0], "Z", w / 2.0 - 1.0, h);
let cover = outer.fillet(2.0, ">Z") - inner;
for k in 0..6 { cover -= cylinder([(k.to_float() - 2.5) * 10.4, 0, 0], "Z", 2.5, h); }
cover
