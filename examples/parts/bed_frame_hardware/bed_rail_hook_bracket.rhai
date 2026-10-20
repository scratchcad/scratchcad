// Bed rail hook-on bracket pair half: 150 x 40 x 4 mm plate with two 10 x 5 mm hooks on a 76 mm pitch that drop into a slotted post plate, and four 5 mm countersunk screw holes
let length = 150.0; // [110.0, 200.0] Plate length (mm)
let pitch = 76.0; // [50.0, 100.0] Hook pitch (mm)
const t = 4.0;
let plate = box_from_corners([0, 0, 0], [40.0, length, t]);
let hooks = [];
for i in 0..2 {
    let y = length / 2.0 - pitch / 2.0 + pitch * i.to_float();
    hooks.push(box_from_corners([2.0, y - 2.5, -8.0], [12.0, y + 2.5, 0.01]) + box_from_corners([2.0, y - 2.5 - 6.0, -8.0], [12.0, y + 2.5, -5.0]));
}
let holes = [];
for y in [15.0, length * 0.38, length * 0.62, length - 15.0] {
    holes.push(cylinder([28.0, y, -1.0], "Z", 2.5, t + 2.0));
    holes.push(cone(2.5, 5.0, 2.5).translate([28.0, y, t - 2.49]));
}
plate + fuse_all(hooks) - fuse_all(holes)
