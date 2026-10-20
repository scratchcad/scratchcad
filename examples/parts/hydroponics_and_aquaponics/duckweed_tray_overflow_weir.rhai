// Duckweed / grow tray adjustable overflow weir plate: 80 x 65 mm plate 4 mm thick with a 90 degree V notch 15 mm deep in the top edge, two 5 mm height-adjust slots 30 mm long, and a 6 x 6 mm stiffening rib along the bottom edge
let width = 80.0; // [50.0, 150.0] Plate width (mm)
let height = 65.0; // [40.0, 120.0] Plate height (mm)
let notch_depth = 15.0; // [5.0, 30.0] V notch depth (mm)
let slot_len = 30.0; // [10.0, 50.0] Adjust slot length (mm)
const t = 4.0;
let w = width / 2.0;
let nd = min(notch_depth, min(height * 0.4, w - 15.0));
let plate = face(polygon([[-w, 0, 0], [w, 0, 0], [w, 0, height], [nd, 0, height], [0, 0, height - nd], [-nd, 0, height], [-w, 0, height]])).extrude([0, t, 0]);
let rib = box_from_corners([-w, t - 0.5, 0], [w, t + 6.0, 6.0]);
let body = plate + rib;
let sl = min(slot_len, height - nd - 18.0);
let sx = w - 10.0;
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * sx, -1.0, 12.0], "Y", 2.5, t + 2.0));
    cuts.push(cylinder([s * sx, -1.0, 12.0 + sl], "Y", 2.5, t + 2.0));
    cuts.push(box_from_corners([s * sx - 2.5, -1.0, 12.0], [s * sx + 2.5, t + 1.0, 12.0 + sl]));
}
body - fuse_all(cuts)
