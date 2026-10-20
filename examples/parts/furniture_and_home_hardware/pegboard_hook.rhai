// Pegboard hook for 6 mm holes on a 25.4 mm grid: 5 mm rod with a two-prong back, 75 mm arm and an upturned tip
let reach = 75.0; // [40.0, 150.0] Arm length (mm)
let rod = 2.5; // [2.0, 4.0] Rod radius (mm)
let main = circle([0, -8.0, 25.4], [0, 1, 0], rod).to_face().sweep(polyline([[0, -8.0, 25.4], [0, 0, 25.4], [0, 0, 0], [0, reach, 0], [0, reach + 6.0, 12.0]]));
let lower = cylinder([0, -6.0, 0], "Y", rod, 6.5) + cylinder([0, -6.0, -6.0], "Z", rod, 6.0) + sphere([0, -6.0, 0], rod);
fuse_all([main, lower, sphere([0, reach + 6.0, 12.0], rod + 0.5)])
