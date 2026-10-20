// Sink sponge caddy: 110 x 70 x 40 mm open tray, 2 mm walls, 5 drain slots 4 x 50 mm in the floor, 2 keyholes in the back for 12 mm suction cups
let length = 110.0; // [80.0, 160.0] Length (mm)
let depth = 70.0; // [50.0, 100.0] Depth (mm)
let height = 40.0; // [25.0, 60.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let slots = 5; // [3, 8] Drain slots
let outer = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, height]);
let o = outer.fillet(8.0, outer.edges("|Z"));
let inner = box_from_corners([-length / 2.0 + wall, wall, wall], [length / 2.0 - wall, depth - wall, height + 1.0]);
let i = inner.fillet(8.0 - wall, inner.edges("|Z"));
let cuts = [];
let pitch = (length - 30.0) / (slots - 1).to_float();
for k in 0..slots { cuts.push(box_from_corners([-(length - 30.0) / 2.0 + k.to_float() * pitch - 2.0, depth / 2.0 - 25.0, -1], [-(length - 30.0) / 2.0 + k.to_float() * pitch + 2.0, depth / 2.0 + 25.0, wall + 1.0])); }
let keys = [];
for x in [-length * 0.3, length * 0.3] { keys.push(cylinder([x, -1, height * 0.6], "Y", 6.0, wall + 2.0) + box_from_corners([x - 2.5, -1, height * 0.6], [x + 2.5, wall + 1.0, height * 0.6 + 9.0])); }
o - i - compound(cuts) - compound(keys)
