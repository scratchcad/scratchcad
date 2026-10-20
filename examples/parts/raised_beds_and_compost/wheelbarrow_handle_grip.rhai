// Wheelbarrow handle grip: fits a 32 mm handle, 140 mm long 40 mm OD with finger ridges every 13 mm and an end flare 46 mm
let handle = 32.0; // [25.0, 40.0] Handle diameter (mm)
let length = 140.0; // [100.0, 180.0] Grip length (mm)
let od = 40.0; // [32.0, 50.0] Grip OD (mm)
let p = sketch("XZ").move_to(handle / 2.0, 0).hline_to(od / 2.0 - 1.0).vline_to(length - 12.0).line_to(od / 2.0 + 3.0, length - 6.0).vline_to(length).hline_to(handle / 2.0 - 3.0).vline_to(length - 4.0).hline_to(handle / 2.0).close();
let g = p.face().revolve("Z", 360);
let ridges = [];
let n = ((length - 30.0) / 13.0).floor().to_int();
for k in 0..n { ridges.push(cylinder([0, 0, 15.0 + k.to_float() * 13.0], "Z", od / 2.0 + 1.0, 3.0) - cylinder([0, 0, 14.0 + k.to_float() * 13.0], "Z", od / 2.0 - 1.01, 5.0)); }
g + compound(ridges)
