// Manure spreader beater paddle: 8 mm plate 150 mm long and 90 mm deep, its outer edge cut into 5 saw teeth 18 mm high (leaving at least 50 mm of plate), two 13 mm bolt holes 80 mm apart 20 mm in from the mounting edge for M12 bolts to the beater flight, and a 10 mm square stiffening rib along the plate 45 mm from the mounting edge
let length = 150.0; // [100.0, 220.0] Paddle length (mm)
let depth = 90.0; // [60.0, 130.0] Paddle depth (mm)
let teeth = 5; // [3, 9] Number of teeth
let tooth_h = 18.0; // [8.0, 30.0] Tooth height (mm)
let thickness = 8.0; // [6.0, 12.0] Plate thickness (mm)
let bolt_pitch = 80.0; // [50.0, 140.0] Bolt spacing (mm)
const bolt_d = 13.0;
let th = min(tooth_h, depth - 50.0);
let body_d = depth - th;
let pts = [[0, 0, 0], [length, 0, 0]];
let tw = length / teeth;
for i in 0..teeth {
    let x = length - i * tw;
    pts.push([x, body_d, 0]);
    pts.push([x - tw * 0.35, depth, 0]);
}
pts.push([0, body_d, 0]);
let plate = polygon(pts).to_face().extrude([0, 0, thickness]);
let rib_y = min(45.0, body_d - 8.0);
let rib = box_from_corners([5.0, rib_y - 5.0, thickness - 0.5], [length - 5.0, rib_y + 5.0, thickness + 10.0]);
let bp = min(bolt_pitch, length - 30.0);
(plate + rib) - fuse_all([
    cylinder([length / 2.0 - bp / 2.0, 20.0, -1.0], "Z", bolt_d / 2.0, thickness + 2.0),
    cylinder([length / 2.0 + bp / 2.0, 20.0, -1.0], "Z", bolt_d / 2.0, thickness + 2.0),
])
