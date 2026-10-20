// Kart pedal heel stop plate: 100 x 50 x 5 mm plate with 5 mm rounded corners, four 3 mm grip ribs 4 mm tall evenly spaced across the top, a 5 mm thick heel lip 12 mm tall at the back, and two 6.5 x 16 mm M6 slots for the floor tray
let length = 100.0; // [90.0, 140.0] Plate length (mm)
let width = 50.0; // [40.0, 80.0] Plate width (mm)
let lip_h = 12.0; // [6.0, 25.0] Heel lip height (mm)
let ribs = 4; // [2, 6] Number of grip ribs
const t = 5.0;
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(5.0, plate.edges("|Z"));
let parts = [plate];
let pitch = (length - 50.0) / ribs.to_float();
for i in 0..ribs {
    let x = -length / 2.0 + 20.0 + (i.to_float() + 0.5) * pitch;
    parts.push(box_centered(3.0, width - 12.0, 4.5).translate([x, 0, t + 1.75]));
}
parts.push(box_from_corners([-length / 2.0 + 5.0, -width / 2.0 + 5.0, t - 0.5], [-length / 2.0 + 10.0, width / 2.0 - 5.0, t + lip_h]));
let body = fuse_all(parts);
let cuts = [];
for s in [-1.0, 1.0] {
    let y = s * (width / 2.0 - 12.0);
    let x = length / 2.0 - 14.0;
    cuts.push(box_centered(9.5, 6.5, t + 2.0).translate([x, y, t / 2.0]));
    cuts.push(cylinder([x - 4.75, y, -1.0], "Z", 3.25, t + 2.0));
    cuts.push(cylinder([x + 4.75, y, -1.0], "Z", 3.25, t + 2.0));
}
body - fuse_all(cuts)
