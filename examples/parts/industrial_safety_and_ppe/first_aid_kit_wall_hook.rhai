// First aid kit wall bracket: keyhole hanger plate 80 x 60 mm, 5 mm thick, two 30 mm-tall 45 degree hooks 8 mm wide for the kit's back slots, two 5 mm countersunk screw holes
let width = 80.0; // [60.0, 140.0] Plate width (mm)
let height = 60.0; // [40.0, 100.0] Plate height (mm)
let thickness = 5.0; // [3.0, 8.0] Plate thickness (mm)
let hook_width = 8.0; // [5.0, 15.0] Hook width (mm)
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thickness, height]);
let p = plate.fillet(6.0, plate.edges("|Y"));
let hooks = [];
for sx in [-1.0, 1.0] {
    let hp = polygon("YZ", [[1.0, height * 0.4 - 1.0], [-12.0, height * 0.4 + 12.0], [-12.0, height * 0.4 + 30.0], [-8.0, height * 0.4 + 30.0], [-8.0, height * 0.4 + 16.0], [1.0, height * 0.4 + 8.0]]);
    hooks.push(hp.to_face().extrude([hook_width, 0, 0]).translate([sx * width * 0.3 - hook_width / 2.0, 0, 0]));
}
let screws = [];
for sx in [-1.0, 1.0] {
    screws.push(cylinder([sx * width * 0.3, -1.0, height * 0.2], "Y", 2.5, thickness + 2.0));
    screws.push(cone(2.5, 6.0, 3.5).rotate_x(90.0).translate([sx * width * 0.3, 2.5, height * 0.2]));
}
p + fuse_all(hooks) - fuse_all(screws)
