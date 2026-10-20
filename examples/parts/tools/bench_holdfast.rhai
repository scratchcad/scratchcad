// Forged bench holdfast for 19 mm holes: 18 mm shaft 200 mm long, mitred bends to a 150 mm arm, 30 mm pad
let shaft = 200.0; // [150.0, 300.0] Shaft length (mm)
let arm = 150.0; // [100.0, 200.0] Arm reach (mm)
let path = polyline([[0, 0, 0], [0, 0, shaft], [30.0, 0, shaft + 30.0], [arm, 0, shaft + 10.0], [arm + 10.0, 0, shaft - 20.0]]);
let rod = circle([0, 0, 0], [0, 0, 1], 9.0).to_face().sweep(path);
rod + cylinder([arm + 10.0, 0, shaft - 26.0], "Z", 15.0, 6.0)
