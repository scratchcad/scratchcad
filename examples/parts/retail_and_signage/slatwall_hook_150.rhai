// Slatwall hook, 150 mm prong: 4.8 mm wire, 32 x 12 mm insert tab for 75 mm pitch slatwall, upturned tip
let prong = 150.0; // [50.0, 300.0] Prong length (mm)
let wire = 4.8; // [3.5, 6.0] Wire diameter (mm)
let r = wire / 2.0;
let tab = box_from_corners([-16.0, -3.0, -2.0], [16.0, 0, 10.0]);
let lip = box_from_corners([-16.0, 0, 7.0], [16.0, 6.0, 10.0]);
let plate = box_from_corners([-16.0, 6.0, -15.0], [16.0, 8.0, 10.0]);
let p = cylinder([0, 6.5, -5.0], "Y", r, prong + 1.5) + sphere([0, 8.0 + prong, -5.0], r + 0.4) + cylinder([0, 8.0 + prong, -5.0], "Z", r, 20.0) + sphere([0, 8.0 + prong, 15.0], r + 0.4);
tab + lip + plate + p
