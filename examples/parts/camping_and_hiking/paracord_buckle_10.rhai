// Paracord bracelet buckle, 3/8 in contoured side-release, male half: 10 mm strap, 30 x 16 x 6 mm
let strap = 10.0; // [8.0, 20.0] Strap width (mm)
let thickness = 6.0; // [4.0, 8.0] Thickness (mm)
let base = box_from_corners([0, -strap / 2.0 - 3.0, 0], [8.0, strap / 2.0 + 3.0, thickness]) - box_from_corners([2.0, -strap / 2.0, -1], [5.0, strap / 2.0, thickness + 1.0]);
let prongs = [];
for s in [-1.0, 1.0] {
    let p = box_from_corners([7.99, s * (strap / 2.0 + 0.5) - 1.0, 0.8], [22.0, s * (strap / 2.0 + 0.5) + 1.0, thickness - 0.8]);
    let barb = polygon([[18.0, s * (strap / 2.0 + 1.5)], [22.0, s * (strap / 2.0 + 1.5)], [22.0, s * (strap / 2.0 + 3.0)]]).to_face().extrude([0, 0, thickness - 1.6]).translate([0, 0, 0.8]);
    prongs.push(p + barb);
}
let tongue = box_from_corners([7.99, -2.0, 1.5], [24.0, 2.0, thickness - 1.5]);
base + fuse_all(prongs) + tongue
