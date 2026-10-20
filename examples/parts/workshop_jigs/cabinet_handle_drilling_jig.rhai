// Cabinet handle drilling jig: 180 x 50 x 6 mm plate, 4.2 mm hole pairs for 64, 96, 128 and 160 mm handle centres, 6 mm edge fence 15 mm deep, centre sight notches
let hole_d = 4.2; // [3.0, 6.0] Screw hole diameter (mm)
let row1 = 18.0; // [10.0, 25.0] Short-handle row from the fence (mm)
let row2 = 34.0; // [26.0, 45.0] Long-handle row from the fence (mm)
let t = 6.0; // [4.0, 10.0] Plate thickness (mm)
let w = row2 + 16.0;
let plate = box_from_corners([-90.0, 0, 0], [90.0, w, t]);
let p = plate.fillet(4.0, plate.edges("|Z and >Y"));
let fence = box_from_corners([-90.0, -6.0, -15.0], [90.0, 0.01, t]);
let cuts = [];
for c in [[32.0, row1], [48.0, row1], [64.0, row2], [80.0, row2]] {
    for s in [-1.0, 1.0] { cuts.push(cylinder([s * c[0], c[1], -1], "Z", hole_d / 2.0, t + 2.0)); }
}
let notch = polygon([[-2.0, w + 0.01, -1], [2.0, w + 0.01, -1], [0, w - 3.0, -1]]).to_face().extrude([0, 0, t + 2.0]);
let notch2 = polygon([[-1.5, -6.01, -16.0], [1.5, -6.01, -16.0], [0, -3.5, -16.0]]).to_face().extrude([0, 0, 23.0]);
p + fence - compound(cuts) - notch - notch2
