// 20 mm PVC conduit coupling: 25 mm OD 50 mm long, 20.3 mm sockets either side meeting at a 2 mm internal stop ring
let conduit = 20.0; // [16.0, 40.0] Conduit OD (mm)
let r = conduit / 2.0 + 0.15;
cylinder(r + 2.3, 50.0).chamfer(0.5, "%CIRCLE") - cylinder([0, 0, -1], "Z", r, 25.0) - cylinder([0, 0, 26.0], "Z", r, 25.0) - cylinder([0, 0, 23.0], "Z", r - 1.5, 4.0)
