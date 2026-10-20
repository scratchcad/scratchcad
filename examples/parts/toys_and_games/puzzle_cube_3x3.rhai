// 57 mm 3x3 puzzle cube shell: rounded cube with 1 mm grooves dividing each face into nine cubies, and recessed 15 mm tile pockets
let s = 57.0; // [40.0, 70.0] Cube size (mm)
let c = s / 3.0;
let cube = box_centered(s, s, s).fillet(2.5);
let grooves = [];
for k in [-0.5, 0.5] {
    grooves.push(box_centered(1.0, s + 2.0, s + 2.0).translate([k * c, 0, 0]));
    grooves.push(box_centered(s + 2.0, 1.0, s + 2.0).translate([0, k * c, 0]));
    grooves.push(box_centered(s + 2.0, s + 2.0, 1.0).translate([0, 0, k * c]));
}
let shell = cube - (fuse_all(grooves) - box_centered(s - 2.0, s - 2.0, s - 2.0));
let tiles = [];
for i in [-1.0, 0.0, 1.0] { for j in [-1.0, 0.0, 1.0] { tiles.push(box_centered(c - 4.0, c - 4.0, 0.8).translate([i * c, j * c, s / 2.0 - 0.3])); } }
shell - fuse_all(tiles)
