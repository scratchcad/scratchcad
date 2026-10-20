// Curtain tieback holdback hook: 60 mm projection, 12 mm rod, 50 mm rose plate with 2 screw holes, 30 mm upturn
let reach = 60.0; // [40.0, 100.0] Projection (mm)
let rod = 12.0; // [8.0, 16.0] Rod diameter (mm)
let rose = 50.0; // [35.0, 70.0] Rose diameter (mm)
let r = rod / 2.0;
let plate = cylinder([0, 0, 0], "Y", rose / 2.0, 6.0);
let p = plate.fillet(2.0, plate.edges("%CIRCLE").filter(|e| e.center().y > 3.0));
let arm = cylinder([0, 5.99, 0], "Y", r, reach - 6.0);
let elbow = sphere([0, reach, 0], r + 0.4);
let up = cylinder([0, reach, 0], "Z", r, 30.0) + sphere([0, reach, 30.0], r + 2.0);
p + arm + elbow + up - cylinder([0, -1, rose / 2.0 - 8.0], "Y", 2.2, 8.0) - cylinder([0, -1, -rose / 2.0 + 8.0], "Y", 2.2, 8.0)
