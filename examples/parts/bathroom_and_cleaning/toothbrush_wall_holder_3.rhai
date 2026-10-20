// Wall-mounted toothbrush holder for 3 brushes: 120 x 40 x 4 mm back plate, 30 mm shelf with 12 mm keyhole slots open to the front, 2 x 4 mm screw holes
let brushes = 3; // [2, 6] Number of brushes
let pitch = 36.0; // [28.0, 50.0] Brush spacing (mm)
let depth = 30.0; // [22.0, 40.0] Shelf depth (mm)
let slot_d = 12.0; // [9.0, 16.0] Brush slot diameter (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let w = brushes.to_float() * pitch + 12.0;
let back = box_from_corners([-w / 2.0, -t, 0], [w / 2.0, 0.01, 40.0]);
let shelf = box_from_corners([-w / 2.0, 0, 30.0], [w / 2.0, depth, 30.0 + t]);
let s = shelf.fillet(4.0, shelf.edges("|Z and >Y"));
let cuts = [];
for i in 0..brushes {
    let x = (i.to_float() - (brushes.to_float() - 1.0) / 2.0) * pitch;
    cuts.push(cylinder([x, depth * 0.5, 29.0], "Z", slot_d / 2.0, t + 2.0));
    cuts.push(box_from_corners([x - slot_d * 0.3, depth * 0.5, 29.0], [x + slot_d * 0.3, depth + 1.0, 31.0 + t]));
}
let screws = [cylinder([-w / 2.0 + 8.0, -t - 1.0, 15.0], "Y", 2.0, t + 2.0), cylinder([w / 2.0 - 8.0, -t - 1.0, 15.0], "Y", 2.0, t + 2.0)];
back + s - fuse_all(cuts) - compound(screws)
