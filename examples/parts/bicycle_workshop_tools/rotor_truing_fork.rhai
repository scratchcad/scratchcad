// Disc rotor truing fork: 130 x 16 x 8 mm steel bar with 1 mm chamfered edges, a 2.0 mm slot 14 mm deep at one end and a 2.3 mm slot 10 mm deep at the other, for straightening bent rotors
let length = 130.0; // [100.0, 180.0] Length (mm)
let width = 16.0; // [12.0, 22.0] Width (mm)
let thickness = 8.0; // [6.0, 12.0] Thickness (mm)
let slot_a = 2.0; // [1.6, 2.4] First slot width (mm)
let slot_b = 2.3; // [1.6, 2.6] Second slot width (mm)
const depth_a = 14.0;
const depth_b = 10.0;
let bar = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let bar = bar.chamfer(1.0, bar.edges("|X"));
let cuts = fuse_all([
    box_from_corners([-1.0, -slot_a / 2.0, -1.0], [depth_a, slot_a / 2.0, thickness + 1.0]),
    box_from_corners([length - depth_b, -slot_b / 2.0, -1.0], [length + 1.0, slot_b / 2.0, thickness + 1.0]),
]);
bar - cuts
