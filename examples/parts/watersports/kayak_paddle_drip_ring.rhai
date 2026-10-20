// Kayak paddle drip ring: fits a 30 mm shaft, 70 mm OD flared cup 15 mm, 1.5 mm split for fitting
let shaft = 30.0; // [26.0, 34.0] Shaft diameter (mm)
let od = 70.0; // [50.0, 90.0] Ring diameter (mm)
let height = 15.0; // [10.0, 25.0] Height (mm)
let p = sketch("XZ").move_to(shaft / 2.0, 0).hline_to(shaft / 2.0 + 4.0).line_to(od / 2.0, height).hline_to(od / 2.0 - 2.5).line_to(shaft / 2.0 + 3.0, 3.0).vline_to(height * 0.6).hline_to(shaft / 2.0).close();
let ring = p.face().revolve("Z", 360);
ring - box_from_corners([-0.75, 0, -1], [0.75, od, height + 1.0])
