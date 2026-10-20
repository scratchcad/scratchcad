// Kart data logger mount for the steering wheel: 6 mm plate 110 x 50 mm with 4 mm rounded corners and two M5 holes (5.3 mm) 80 mm apart for the logger, standing on two 20 mm round pillars 20 mm tall, 70 mm apart, with M6 clearance holes (6.4 mm) counterbored 11 mm to the wheel spokes
let plate_w = 110.0; // [90.0, 150.0] Plate width (mm)
let plate_d = 50.0; // [35.0, 70.0] Plate depth (mm)
let pillar_h = 20.0; // [8.0, 40.0] Pillar height (mm)
let spoke_spacing = 70.0; // [40.0, 90.0] Wheel spoke hole spacing (mm)
const plate_t = 6.0;
const logger_spacing = 80.0;
let plate = box_centered(plate_w, plate_d, plate_t).translate([0, 0, pillar_h + plate_t / 2.0]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let pillars = [];
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * min(spoke_spacing, plate_w - 24.0) / 2.0;
    pillars.push(cylinder([x, 0, 0], "Z", 10.0, pillar_h + 1.0));
    cuts.push(cylinder([x, 0, -1.0], "Z", 3.2, pillar_h + plate_t + 2.0));
    cuts.push(cylinder([x, 0, pillar_h + plate_t - 5.0], "Z", 5.5, 6.0));
    cuts.push(cylinder([s * logger_spacing / 2.0, plate_d / 2.0 - 8.0, pillar_h - 1.0], "Z", 2.65, plate_t + 2.0));
}
let body = plate + fuse_all(pillars);
body - fuse_all(cuts)
