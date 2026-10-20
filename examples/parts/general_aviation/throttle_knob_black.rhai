// Push-pull throttle knob: 38 mm mushroom 25 mm tall, 1/4-28 threaded 6.4 mm bore 15 mm, 12 grip flutes
let diameter = 38.0; // [25.0, 50.0] Knob diameter (mm)
let height = 25.0; // [18.0, 35.0] Height (mm)
let bore = 6.4; // [5.0, 10.0] Shaft bore (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(7.0).line_to(diameter / 2.0 - 2.0, height * 0.5).line_to(diameter / 2.0, height * 0.7).line_to(diameter / 2.0 - 1.5, height * 0.9).line_to(diameter / 2.0 - 5.0, height).hline_to(0).close();
let k = p.face().revolve("Z", 360);
let flutes = [];
for i in 0..12 { flutes.push(cylinder([diameter / 2.0 + 1.0, 0, height * 0.45], "Z", 2.2, height).rotate_z(i.to_float() * 30.0)); }
k - fuse_all(flutes) - cylinder([0, 0, -1], "Z", bore / 2.0, 16.0)
