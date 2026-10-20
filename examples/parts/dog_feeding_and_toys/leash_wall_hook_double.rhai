// Double dog leash wall hook: 120 x 40 x 6 mm backplate with two 40 mm hooks 10 mm thick angled up 20 degrees with 10 mm upturned tips and three 4.5 mm screw holes
let width = 120.0; // [80.0, 200.0] Plate width (mm)
let reach = 40.0; // [25.0, 60.0] Hook reach (mm)
const t = 6.0;
let plate = box_from_corners([0, 0, 0], [width, t, 40.0]);
let plate = plate.fillet(5.0, plate.edges("|Y"));
let hooks = [];
for x in [width * 0.25, width * 0.75] {
    let arm = box_from_corners([-5.0, 0, 0], [5.0, reach, 10.0]) + box_from_corners([-5.0, reach - 8.0, 0], [5.0, reach, 20.0]);
    hooks.push(arm.rotate_x(20.0).translate([x, t - 1.0, 8.0]));
}
let holes = [];
for x in [12.0, width / 2.0, width - 12.0] { holes.push(cylinder([x, -1.0, 30.0], "Y", 2.25, t + 2.0)); }
plate + fuse_all(hooks) - fuse_all(holes)
