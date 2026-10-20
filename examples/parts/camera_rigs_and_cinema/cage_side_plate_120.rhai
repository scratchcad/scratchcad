// Camera cage side plate: 120 x 40 x 8 mm upright with 3 mm corner radii, two 36 x 14 mm lightening slots, 1/4-20 tapped holes (5.1 mm core) on 12.5 mm pitch down both edges, a 3/8-16 tapped hole (8 mm core) near the top, and a 90 degree 40 x 25 mm foot with two 1/4-20 clearance holes (6.5 mm) for the base plate
let height = 120.0; // [80.0, 180.0] Plate height (mm)
let width = 40.0; // [35.0, 60.0] Plate width (mm)
let thickness = 8.0; // [6.0, 12.0] Plate thickness (mm)
const foot = 25.0;
let plate = box_from_corners([0, -width / 2.0, 0], [thickness, width / 2.0, height]);
let plate = plate.fillet(3.0, plate.edges("|X and >Z"));
let base = box_from_corners([0, -width / 2.0, 0], [foot, width / 2.0, thickness]);
let body = plate + base;
let cuts = [];
let slot_len = (height - thickness - 30.0 - 10.0) / 2.0;
for k in [0.0, 1.0] {
    let z0 = thickness + 14.0 + k * (slot_len + 10.0);
    cuts.push(box_from_corners([-1.0, -7.0, z0], [thickness + 1.0, 7.0, z0 + slot_len]));
}
let n = ((height - thickness - 20.0) / 12.5).to_int();
for i in 0..n {
    let z = thickness + 10.0 + i.to_float() * 12.5;
    for y in [-width / 2.0 + 5.5, width / 2.0 - 5.5] {
        cuts.push(cylinder([-1.0, y, z], "X", 2.55, thickness + 2.0));
    }
}
cuts.push(cylinder([-1.0, 0, height - 7.0], "X", 4.0, thickness + 2.0));
for y in [-10.0, 10.0] {
    cuts.push(cylinder([thickness + (foot - thickness) / 2.0, y, -1.0], "Z", 3.25, thickness + 2.0));
}
body - fuse_all(cuts)
