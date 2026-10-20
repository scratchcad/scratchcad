// Heavy garage wall J-hook for ladders and hoses: 60 x 100 x 6 mm wall plate, 30 mm wide arm 10 mm thick reaching 120 mm, 45 mm upturned tip, two 5 mm countersunk screw holes
let reach = 120.0; // [60.0, 250.0] Reach from the wall (mm)
let tip_height = 45.0; // [20.0, 80.0] Tip height (mm)
let arm_width = 30.0; // [15.0, 50.0] Arm width (mm)
let arm_t = 10.0; // [6.0, 16.0] Arm thickness (mm)
let plate_height = 100.0; // [60.0, 160.0] Wall plate height (mm)
let plate_width = 60.0; // [40.0, 100.0] Wall plate width (mm)
const plate_t = 6.0;
const screw = 5.0;
let pw = max(plate_width, arm_width + 2.0 * screw);
let plate = box_from_corners([0, -pw / 2.0, 0], [plate_t, pw / 2.0, plate_height]).fillet(6.0, "|X");
let prof = sketch("XZ").move_to(plate_t - 1.0, 0).hline_to(reach).vline_to(tip_height).hline(-arm_t).vline_to(arm_t + 6.0)
    .arc_to(reach - arm_t - 1.76, arm_t + 1.76, reach - arm_t - 6.0, arm_t).hline_to(plate_t + 15.0).line_to(plate_t, arm_t + 25.0).hline_to(plate_t - 1.0).close();
let arm = prof.to_face().extrude([0, arm_width, 0]).translate([0, -arm_width / 2.0, 0]);
arm = arm.fillet(2.0, arm.edges("|Y").filter(|e| e.center().x > reach - arm_t - 0.1 && e.center().z > tip_height - 0.1 || e.center().x > reach - 0.1 && e.center().z < 0.1));
let hook = plate + arm;
for z in [plate_height - 15.0, arm_t + 40.0] {
    hook = hook - cylinder([-1.0, 0, z], "X", screw / 2.0, plate_t + 2.0) - cone(screw / 2.0 + 2.5, screw / 2.0, 2.5).rotate_y(90.0).translate([-0.01, 0, z]);
}
hook
