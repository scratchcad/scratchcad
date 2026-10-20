// Kart rear axle bearing hanger for a 30 mm axle: 13 mm thick housing ring 75 mm OD with a 55 mm bore for a 6006 bearing and a 1.5 mm retaining lip down to 50 mm, three M6 tapped holes (5 mm core) on a 65 mm PCD for the retainer, on a 6 mm plate 120 mm wide dropping 60 mm to two 8.5 x 20 mm M8 slots for the chassis bracket
let bearing_od = 55.0; // [47.0, 62.0] Bearing outside diameter (mm)
let drop = 60.0; // [45.0, 90.0] Axle height above the slots (mm)
let width = 120.0; // [100.0, 160.0] Plate width (mm)
let plate_t = 6.0; // [5.0, 10.0] Plate thickness (mm)
const ring_t = 13.0;
const lip = 1.5;
let ring_r = bearing_od / 2.0 + 10.0;
let pcd = bearing_od + 10.0;
let w = width / 2.0;
let plate = face(polygon([[-w, 0, 0], [w, 0, 0], [w, 0, 22.0], [28.0, 0, drop], [-28.0, 0, drop], [-w, 0, 22.0]])).extrude([0, plate_t, 0]);
let ring = cylinder([0, 0, drop], "Y", ring_r, ring_t);
let body = plate + ring;
let cuts = [
    cylinder([0, lip, drop], "Y", bearing_od / 2.0, ring_t),
    cylinder([0, -1.0, drop], "Y", bearing_od / 2.0 - 2.5, ring_t + 2.0)
];
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 90.0) * PI() / 180.0;
    cuts.push(cylinder([pcd / 2.0 * cos(a), -1.0, drop + pcd / 2.0 * sin(a)], "Y", 2.5, ring_t + 2.0));
}
for s in [-1.0, 1.0] {
    let x = s * (w - 18.0);
    cuts.push(box_centered(11.5, plate_t + 2.0, 8.5).translate([x, plate_t / 2.0, 11.0]));
    cuts.push(cylinder([x - 5.75, -1.0, 11.0], "Y", 4.25, plate_t + 2.0));
    cuts.push(cylinder([x + 5.75, -1.0, 11.0], "Y", 4.25, plate_t + 2.0));
}
body - fuse_all(cuts)
