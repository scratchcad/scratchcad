// Washroom aerosol air freshener can cradle: 3 mm back plate 80 x 140 mm with 6 mm corner radii and two 4 mm keyhole slots (9 mm heads), and two 3 mm open-front ring cradles 12 mm tall for a 65 mm can, 90 mm apart, each joined to the plate by a 10 mm stand-off web
let can_d = 65.0; // [45.0, 75.0] Can diameter (mm)
let plate_h = 140.0; // [100.0, 200.0] Plate height (mm)
let ring_spacing = 90.0; // [50.0, 150.0] Cradle ring spacing (mm)
let opening = 0.7; // [0.5, 0.85] Front opening as a fraction of the diameter
const t = 3.0;
const ring_h = 12.0;
const standoff = 10.0;
let ri = can_d / 2.0 + 0.5;
let ro = ri + t;
let pw = max(80.0, 2.0 * ro + 6.0);
let plate = box_from_corners([-pw / 2.0, 0, 0], [pw / 2.0, t, plate_h]);
let plate = plate.fillet(6.0, plate.edges("|Y"));
let yc = t + standoff + ri;
let rs = min(ring_spacing, plate_h - ring_h - 30.0);
let parts = [plate];
let cuts = [];
for z in [10.0, 10.0 + rs] {
    let ring = cylinder([0, yc, z], "Z", ro, ring_h) - cylinder([0, yc, z - 1.0], "Z", ri, ring_h + 2.0);
    let ow = opening * can_d;
    parts.push(ring - box_from_corners([-ow / 2.0, yc, z - 1.0], [ow / 2.0, yc + ro + 1.0, z + ring_h + 1.0]));
    parts.push(box_from_corners([-6.0, t - 0.5, z], [6.0, yc - ri + 1.0, z + ring_h]));
    cuts.push(cylinder([0, yc, z - 1.0], "Z", ri, ring_h + 2.0));
}
let body = fuse_all(parts) - fuse_all(cuts);
let kz = plate_h - 15.0;
let keys = [];
for x in [-pw / 4.0, pw / 4.0] {
    keys.push(cylinder([x, -1.0, kz], "Y", 4.5, t + 2.0));
    keys.push(cylinder([x, -1.0, kz + 7.0], "Y", 2.0, t + 2.0));
    keys.push(box_from_corners([x - 2.0, -1.0, kz], [x + 2.0, t + 1.0, kz + 7.0]));
}
(body - fuse_all(keys)).mirror("XZ")
