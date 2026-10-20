// Brick trowel: 280 x 130 mm pointed 1.5 mm blade, cranked 10 mm shank rising 50 mm, 30 mm wooden handle 120 mm long
let len = 280.0; // [200.0, 330.0] Blade length (mm)
let w = 130.0; // [100.0, 160.0] Blade width (mm)
let blade = polygon([[0, 0], [len * 0.3, -w / 2.0], [len, -w * 0.18], [len, w * 0.18], [len * 0.3, w / 2.0]]).to_face().extrude(1.5);
let shank = circle([len - 20.0, 0, 1.0], [0, 0, 1], 5.0).to_face().sweep(polyline([[len - 20.0, 0, 1.0], [len - 20.0, 0, 50.0], [len + 20.0, 0, 50.0]]));
let handle = cylinder([len + 15.0, 0, 50.0], "X", 15.0, 120.0).fillet(6.0, "%CIRCLE");
fuse_all([blade, shank, handle])
