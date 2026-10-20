// VESA 100 adapter plate: 120 x 120 x 4 mm with rounded corners, four 5.2 mm holes 100 mm apart, 75 mm slots and a 50 mm lightening window
let size = 120.0; // [110.0, 150.0] Plate size (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let plate = box_centered(size, size, t).fillet(8.0, "|Z");
let cuts = [box_centered(50.0, 50.0, t + 2.0).fillet(5.0, "|Z")];
for x in [-50.0, 50.0] { for y in [-50.0, 50.0] { cuts.push(cylinder([x, y, -t], "Z", 2.6, 2.0 * t)); } }
for x in [-37.5, 37.5] { for y in [-37.5, 37.5] { cuts.push(cylinder([x, y, -t], "Z", 2.6, 2.0 * t)); } }
plate - fuse_all(cuts)
