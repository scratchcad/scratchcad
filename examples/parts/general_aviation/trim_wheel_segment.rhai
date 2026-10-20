// Elevator trim wheel: 100 mm wheel 12 mm wide, 30 grip notches, 4 lightening holes, 8 mm keyed hub
let diameter = 100.0; // [70.0, 150.0] Wheel diameter (mm)
let width = 12.0; // [8.0, 20.0] Rim width (mm)
let hub = 8.0; // [6.0, 12.0] Axle bore (mm)
let w = cylinder(diameter / 2.0, width);
let notches = [];
for k in 0..30 { notches.push(cylinder([diameter / 2.0 + 1.0, 0, -1], "Z", 2.5, width + 2.0).rotate_z(k.to_float() * 12.0)); }
let holes = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([diameter * 0.25 * a.cos(), diameter * 0.25 * a.sin(), -1], "Z", diameter * 0.12, width + 2.0)); }
let web = cylinder([0, 0, -1], "Z", diameter / 2.0 - 8.0, width / 2.0 - 2.0 + 1.0) - cylinder([0, 0, -2], "Z", hub, width);
w - compound(notches) - compound(holes) - web - cylinder([0, 0, -1], "Z", hub / 2.0, width + 2.0) - box_from_corners([hub / 2.0 - 0.5, -1.0, -1], [hub / 2.0 + 1.5, 1.0, width + 1.0])
