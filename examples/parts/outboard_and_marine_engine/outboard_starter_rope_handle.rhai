// Outboard recoil starter rope handle: 95 mm long T grip, 24 mm ends waisting to 20 mm in the middle for the fingers, 2 mm chamfered ends, with a 5 mm rope hole through the middle and a 12 mm knot counterbore 8 mm deep from the top
let length = 95.0; // [70.0, 130.0] Handle length (mm)
let grip_d = 24.0; // [18.0, 32.0] Grip end diameter (mm)
let rope_d = 5.0; // [3.0, 8.0] Rope diameter (mm)
const waist = 2.0;
let r = grip_d / 2.0;
let l = length / 2.0;
let profile = polygon([[-l, 0, 0], [l, 0, 0], [l, 0, r - 2.0], [l - 2.0, 0, r], [l - 15.0, 0, r], [l - 30.0, 0, r - waist], [-l + 30.0, 0, r - waist], [-l + 15.0, 0, r], [-l + 2.0, 0, r], [-l, 0, r - 2.0]]);
let handle = face(profile).revolve("X", 360.0);
let cuts = [cylinder([0, 0, -r - 1.0], "Z", rope_d / 2.0 + 0.3, 2.0 * r + 2.0), cylinder([0, 0, r - waist - 8.0], "Z", min(6.0, r - waist - 2.0), 10.0)];
handle - fuse_all(cuts)
