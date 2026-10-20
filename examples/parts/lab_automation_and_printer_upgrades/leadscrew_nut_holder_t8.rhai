// Holder plate for a T8 leadscrew flange nut: 40 x 30 x 5 mm plate, 10.5 mm nut bore, 4 x M3 holes on the nut's 16 mm bolt circle at 45 degrees, 2 x M3 slots 8 mm long for adjusting the plate on the carriage
let length = 40.0; // [36.0, 70.0] Plate length (mm)
let width = 30.0; // [26.0, 50.0] Plate width (mm)
let t = 5.0; // [3.0, 10.0] Plate thickness (mm)
let nut_bore = 10.5; // [8.5, 12.0] Nut barrel bore (mm)
let slot_l = 8.0; // [0.0, 12.0] Adjustment slot length (mm)
const pcd = 16.0;
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
plate = plate.fillet(3.0, "|Z");
let cuts = [cylinder([0, 0, -1], "Z", nut_bore / 2.0, t + 2.0)];
for k in 0..4 {
    let a = (45.0 + k.to_float() * 90.0) * PI() / 180.0;
    cuts.push(cylinder([pcd / 2.0 * a.cos(), pcd / 2.0 * a.sin(), -1], "Z", 1.6, t + 2.0));
}
let sl = min(slot_l, width - 12.0);
for sx in [-1.0, 1.0] {
    let x = sx * (length / 2.0 - 5.0);
    if sl > 0.5 {
        cuts.push(fuse_all([cylinder([x, -sl / 2.0, -1], "Z", 1.7, t + 2.0), cylinder([x, sl / 2.0, -1], "Z", 1.7, t + 2.0), box_centered(3.4, sl, t + 2.0).translate([x, 0, t / 2.0])]));
    } else {
        cuts.push(cylinder([x, 0, -1], "Z", 1.7, t + 2.0));
    }
}
plate - fuse_all(cuts)
