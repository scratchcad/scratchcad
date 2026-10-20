// Wall clip for a pen-style probe thermometer: 40 x 90 mm back plate 3 mm thick, two snap rings for a 20 mm thermometer body (2 mm wall, 14 mm opening) and two 4 mm screw holes
let body_d = 20.0; // [12.0, 28.0] Thermometer body diameter (mm)
let spacing = 50.0; // [30.0, 70.0] Ring spacing (mm)
const t = 3.0;
const ring_w = 10.0;
const wall = 2.0;
let ri = body_d / 2.0 + 0.2;
let ro = ri + wall;
let plate_h = spacing + 40.0;
let plate = box_from_corners([-20.0, -t, 0], [20.0, 0, plate_h]);
let rings = [];
let cuts = [];
for z in [plate_h / 2.0 - spacing / 2.0 - ring_w / 2.0, plate_h / 2.0 + spacing / 2.0 - ring_w / 2.0] {
    rings.push(cylinder([0, ri + 1.0, z], "Z", ro, ring_w) + box_from_corners([-ro, -0.01, z], [ro, ri + 1.0, z + ring_w]));
    cuts.push(cylinder([0, ri + 1.0, z - 1.0], "Z", ri, ring_w + 2.0));
    cuts.push(box_from_corners([-body_d * 0.35, ri + 1.0, z - 1.0], [body_d * 0.35, 2.0 * ro + 5.0, z + ring_w + 1.0]));
}
let clip = plate + fuse_all(rings) - fuse_all(cuts);
clip - cylinder([0, -t - 1.0, 8.0], "Y", 2.0, t + 2.0) - cylinder([0, -t - 1.0, plate_h - 8.0], "Y", 2.0, t + 2.0)
