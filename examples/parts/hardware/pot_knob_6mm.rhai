// Potentiometer knob for a 6 mm D shaft: 20 mm diameter, 16 mm tall, 24 grip flutes, pointer line, 12 mm shaft depth
let diameter = 20.0; // [10.0, 40.0] Diameter (mm)
let height = 16.0; // [8.0, 30.0] Height (mm)
let flutes = 24; // [0, 48] Grip flutes
let shaft_d = 6.0; // [3.0, 8.0] Shaft diameter (mm)
let depth = 12.0; // [6.0, 20.0] Shaft hole depth (mm)
let knob = cone(diameter / 2.0, diameter / 2.0 * 0.92, height).fillet(1.5, ">Z");
let cuts = [];
for i in 0..flutes { cuts.push(cylinder([diameter / 2.0 + 0.3, 0, -1], "Z", 0.8, height - 2.0).rotate_z(i.to_float() * 360.0 / flutes.to_float())); }
if flutes > 0 { knob = knob - fuse_all(cuts); }
let pointer = box_centered(1.0, diameter * 0.3, 1.0).translate([0, diameter * 0.25, height]);
let bore = cylinder([0, 0, -1], "Z", shaft_d / 2.0, depth + 1.0) & box_centered(shaft_d, shaft_d, 60).translate([0, -0.75, 0]);
knob - pointer - bore
