// Under-desk headphone hook: 40 x 60 mm clamp plate 4 mm thick with two screw holes, 70 mm arm and 45 mm wide cradle with a lip
let reach = 70.0; // [50.0, 100.0] Arm reach (mm)
let w = 45.0; // [30.0, 60.0] Cradle width (mm)
let plate = box_centered(40.0, 60.0, 4.0).translate([0, 0, 2.0]).fillet(5.0, "|Z");
for y in [-18.0, 18.0] { plate -= cylinder([0, y, -1], "Z", 2.25, 6.0) + cone(2.25, 4.5, 2.25).translate([0, y, 1.76]); }
let arm = polygon([[-15, 0, 0], [15, 0, 0], [8, 0, -reach], [-8, 0, -reach]]).to_face().extrude([0, 6.0, 0]).translate([0, -3.0, 0]);
let cradle = box_centered(w, 30.0, 4.0).translate([0, 12.0, -reach]) + box_centered(w, 4.0, 10.0).translate([0, 25.0, -reach + 3.0]);
fuse_all([plate, arm.rotate_z(90.0).rotate_z(-90.0), cradle]).fillet(1.0, ">Y")
