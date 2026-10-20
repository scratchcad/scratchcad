// Citrus juicer reamer: 60 mm ribbed cone 45 mm tall with 12 ribs, on a 150 mm catch dish 25 mm deep with a pour spout and a side handle
let cone_diameter = 60.0; // [40.0, 90.0] Reamer cone diameter (mm)
let cone_height = 45.0; // [30.0, 70.0] Reamer cone height (mm)
let rib_count = 12; // [6, 20] Number of ribs
let dish_diameter = 150.0; // [100.0, 220.0] Dish diameter (mm)
let dish_depth = 25.0; // [15.0, 40.0] Dish depth (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let rc = cone_diameter / 2.0;
let rd = max(dish_diameter / 2.0, rc + 20.0);
// dish: a revolved hollow with a rolled rim, floor at z = wall
let dish = sketch("XZ").move_to(0, 0).hline_to(rd - 12.0).arc_to(rd - 2.0, 4.0, rd, dish_depth).hline(-wall).arc_to(rd - wall - 2.0, 6.0, rd - 12.0, wall).hline_to(0).close().to_face().revolve("Z", 360);
// reamer: a cone with a rounded tip standing on the dish floor
let reamer = sketch("XZ").move_to(0, wall - 0.1).hline_to(rc).line_to(3.0, wall + cone_height - 2.0).arc_to(1.0, wall + cone_height - 0.3, 0, wall + cone_height).close().to_face().revolve("Z", 360);
let ribs = [];
for i in 0..rib_count {
    let rib = polygon("XZ", [[rc - 1.0, wall], [rc + 1.2, wall], [3.0, wall + cone_height - 1.0], [2.0, wall + cone_height - 2.5]]).to_face().extrude([0, 1.6, 0]).translate([0, -0.8, 0]);
    ribs.push(rib.rotate_z(i.to_float() * 360.0 / rib_count.to_float()));
}
// pour spout on +X and a handle on -X
let spout = polygon("XY", [[rd - 6.0, -12.0], [rd + 14.0, 0.0], [rd - 6.0, 12.0]]).to_face().extrude([0, 0, wall]).translate([0, 0, dish_depth - wall]);
let handle = box_from_corners([-rd - 40.0, -12.0, dish_depth - 4.0], [-rd + 4.0, 12.0, dish_depth]).fillet(10.0, "|Z and <X");
handle -= cylinder([-rd - 28.0, 0, 0], "Z", 6.0, 40.0);
fuse_all([dish, reamer, spout, handle] + ribs)
