// Rope edge protector: 90 degree saddle 150 mm long for ropes up to 11 mm, 4 mm wall, 30 mm legs with a 13 mm rope channel and two 6 mm tie-off holes per leg
let length = 150.0; // [100.0, 250.0] Protector length (mm)
let rope = 11.0; // [9.0, 13.0] Rope diameter (mm)
const wall = 4.0;
const leg = 30.0;
let outer = box_from_corners([0, 0, 0], [leg, length, wall]) + box_from_corners([0, 0, 0], [wall, length, leg]);
let channel = cylinder([wall + rope / 2.0 + 1.0, -1.0, wall + rope / 2.0 + 1.0], "Y", rope / 2.0 + 1.0, length + 2.0);
let guard = box_from_corners([wall - 0.01, 0, wall - 0.01], [wall + rope + 4.0, length, wall + rope + 4.0]) - channel - box_from_corners([wall + rope / 2.0 + 1.0, -1.0, wall + rope / 2.0 + 1.0], [leg, length + 1.0, leg]);
let holes = [];
for y in [20.0, length - 20.0] {
    holes.push(cylinder([leg - 7.0, y, -1.0], "Z", 3.0, wall + 2.0));
    holes.push(cylinder([-1.0, y, leg - 7.0], "X", 3.0, wall + 2.0));
}
outer + guard - fuse_all(holes)
