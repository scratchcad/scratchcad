// Shelf bracket 150 x 200 mm: 4 mm steel L with a curved brace, 3 screw holes each leg
let horizontal = 150.0; // [80.0, 300.0] Shelf leg (mm)
let vertical = 200.0; // [80.0, 300.0] Wall leg (mm)
let width = 25.0; // [15.0, 40.0] Width (mm)
let thickness = 4.0; // [2.0, 8.0] Thickness (mm)
let wall_leg = box(thickness, width, vertical);
let shelf_leg = box(horizontal, width, thickness).translate([0, 0, vertical - thickness]);
let brace = sketch("XZ").move_to(thickness - 0.1, vertical * 0.2).arc_to(horizontal * 0.3, vertical * 0.6, horizontal * 0.75, vertical - thickness + 0.1).line_to(horizontal * 0.75 - 6.0, vertical - thickness + 0.1).arc_to(horizontal * 0.3 - 4.0, vertical * 0.6 + 4.0, thickness - 0.1, vertical * 0.2 + 8.0).close().to_face().extrude([0, thickness, 0]).translate([0, (width - thickness) / 2.0 + thickness, 0]);
let part = fuse_all([wall_leg, shelf_leg, brace]);
for k in 1..=3 {
    part -= cylinder([-1, width / 2.0, vertical * k.to_float() / 4.0], "X", 2.5, thickness + 2.0);
    part -= cylinder([horizontal * k.to_float() / 4.0 + 10.0, width / 2.0, vertical - thickness - 1], "Z", 2.5, thickness + 2.0);
}
part
