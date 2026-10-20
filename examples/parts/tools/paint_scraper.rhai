// Paint scraper: 60 x 40 x 1 mm blade with a bevelled edge, 20 mm ferrule, 25 mm handle 100 mm long
let w = 60.0; // [30.0, 100.0] Blade width (mm)
let blade = polygon([[-w / 2.0, 0], [w / 2.0, 0], [12.0, 40.0], [-12.0, 40.0]]).to_face().extrude(1.0) - polygon([[-w / 2.0 - 1.0, -0.01, 1.01], [w / 2.0 + 1.0, -0.01, 1.01], [w / 2.0 + 1.0, 4.0, 1.01]]).to_face().extrude(1.0);
let blade2 = polygon([[-w / 2.0, 0], [w / 2.0, 0], [12.0, 40.0], [-12.0, 40.0]]).to_face().extrude(1.0);
let ferrule = cylinder([0, 38.0, 0.5], "Y", 10.0, 20.0);
let handle = cylinder([0, 56.0, 0.5], "Y", 12.5, 100.0).fillet(5.0, ">Y");
fuse_all([blade2, ferrule, handle])
