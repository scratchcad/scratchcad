// Acoustic panel Z-clip: 75 mm wide, 2 mm aluminium-style section, 30 mm wall leg, 10 mm offset and a 15 mm hook leg, two 4.5 mm countersunk screw holes on 50 mm centres
let width = 75.0; // [40.0, 120.0] Clip width (mm)
let drop = 15.0; // [10.0, 25.0] Hook depth (mm)
const t = 2.0;
const offset = 10.0;
let wall_leg = box_from_corners([0, 0, 0], [t, width, 30.0]);
let web = box_from_corners([0, 0, 30.0 - t], [offset + t, width, 30.0]);
let hook = box_from_corners([offset, 0, 30.0 - drop], [offset + t, width, 30.0]);
let z = wall_leg + web + hook;
let holes = [];
for y in [width / 2.0 - 25.0, width / 2.0 + 25.0] {
    holes.push(cylinder([-1.0, y, 12.0], "X", 2.25, t + 2.0));
    holes.push(cone(2.25, 4.5, 2.26).rotate_y(90.0).translate([-0.25, y, 12.0]));
}
z - fuse_all(holes)
