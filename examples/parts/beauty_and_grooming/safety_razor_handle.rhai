// Double-edge safety razor handle: 90 mm, 12 mm knurled shaft with 20 grooves, M5 threaded post bore 10 mm, 14 mm knob end
let length = 90.0; // [70.0, 120.0] Handle length (mm)
let d = 12.0; // [10.0, 16.0] Shaft diameter (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(7.0).vline_to(6.0).line_to(d / 2.0, 9.0).vline_to(length - 8.0).line_to(7.0, length - 5.0).vline_to(length).hline_to(0).close();
let h = p.face().revolve("Z", 360);
let grooves = [];
for k in 0..20 { grooves.push(cylinder([0, 0, 14.0 + k.to_float() * 3.2], "Z", d, 1.0) - cylinder([0, 0, 13.0 + k.to_float() * 3.2], "Z", d / 2.0 - 0.4, 3.0)); }
h - compound(grooves) - cylinder([0, 0, length - 10.0], "Z", 2.1, 11.0)
