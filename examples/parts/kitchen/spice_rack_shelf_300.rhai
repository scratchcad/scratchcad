// Wall-mounted spice rack shelf: 300 x 70 mm, 4 mm floor, 18 mm front rail, 60 mm back plate with two keyhole slots for 4 mm screws, triangular end brackets
let length = 300.0; // [150.0, 600.0] Shelf length (mm)
let shelf_depth = 70.0; // [50.0, 120.0] Shelf depth (mm)
let thickness = 4.0; // [3.0, 6.0] Material thickness (mm)
let rail_height = 18.0; // [8.0, 40.0] Front rail height (mm)
let back_height = 60.0; // [30.0, 120.0] Back plate height (mm)
let t = thickness;
let floor = box_from_corners([0, 0, 0], [length, shelf_depth, t]);
let rail = box_from_corners([0, 0, 0], [length, t, rail_height]);
let back = box_from_corners([0, shelf_depth - t, 0], [length, shelf_depth, back_height]);
let ends = [];
for x in [0.0, length - t] {
    ends.push(polygon("YZ", [[0, 0], [shelf_depth, 0], [shelf_depth, back_height], [shelf_depth - 15.0, back_height], [0, rail_height]]).to_face().extrude([t, 0, 0]).translate([x, 0, 0]));
}
let shelf = fuse_all([floor, rail, back] + ends);
shelf = shelf.fillet(1.0, shelf.edges("|X").filter(|e| e.center().z > rail_height - 0.1 && e.center().y < t + 0.1));
// keyhole slots through the back plate
for x in [length * 0.2, length * 0.8] {
    let key = cylinder([x, shelf_depth + 1.0, back_height - 25.0], "-Y", 5.0, t + 2.0)
        + box_centered(4.5, t + 2.0, 10.0).translate([x, shelf_depth - t / 2.0, back_height - 20.0])
        + cylinder([x, shelf_depth + 1.0, back_height - 15.0], "-Y", 2.25, t + 2.0);
    shelf -= key;
}
shelf
