// 50 mm putty knife: flexible 1 mm blade tapering from 50 to 25 mm over 90 mm, 25 mm bolster, oval 120 mm handle with hang hole
let w = 50.0; // [25.0, 100.0] Blade width (mm)
let blade = polygon([[-w / 2.0, 0], [w / 2.0, 0], [12.5, 90.0], [-12.5, 90.0]]).to_face().extrude(1.0).fillet(3.0, "|Z and <Y");
let bolster = box_from_corners([-13.0, 88.0, -3.5], [13.0, 100.0, 4.5]).fillet(2.0, "|Y");
let handle = loft([rect(plane([0, 99.0, 0.5], "Y"), 22.0, 12.0), rect(plane([0, 160.0, 0.5], "Y"), 30.0, 18.0), rect(plane([0, 220.0, 0.5], "Y"), 26.0, 16.0)], true);
fuse_all([blade, bolster, handle]) - cylinder([0, 208.0, -10.0], "Z", 4.0, 20.0)
