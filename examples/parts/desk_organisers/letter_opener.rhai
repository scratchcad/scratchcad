// Letter opener: 220 mm overall, 120 mm blade 18 mm wide tapering to a rounded point, blade 3 mm at the spine bevelled to a 0.8 mm edge on both sides, 100 mm x 22 mm handle 10 mm thick with a hanging hole
let blade_l = 120.0; // [80.0, 160.0] Blade length (mm)
let blade_w = 18.0; // [12.0, 25.0] Blade width (mm)
let handle_l = 100.0; // [70.0, 130.0] Handle length (mm)
let handle_w = 22.0; // [16.0, 30.0] Handle width (mm)
let edge = 0.8; // [0.5, 1.5] Edge thickness (mm)

const spine = 3.0;
const handle_t = 10.0;
// blade outline in plan, a cross-section that thins to both edges, intersected
let hw = blade_w / 2.0;
let plan = sketch("XY").move_to(0, -hw).line_to(blade_l - hw, -hw * 0.6).arc_to(blade_l, 0, blade_l - hw, hw * 0.6).line_to(0, hw).close();
let blade = plan.to_face().extrude([0, 0, spine]).translate([0, 0, -spine / 2.0]);
let section = polygon([[-1.0, -hw - 1.0, -edge / 2.0], [-1.0, 0, -spine / 2.0], [-1.0, hw + 1.0, -edge / 2.0], [-1.0, hw + 1.0, edge / 2.0], [-1.0, 0, spine / 2.0], [-1.0, -hw - 1.0, edge / 2.0]]);
blade = blade & section.to_face().extrude([blade_l + 2.0, 0, 0]);
let handle = box_from_corners([-handle_l, -handle_w / 2.0, -handle_t / 2.0], [5.0, handle_w / 2.0, handle_t / 2.0]);
handle = handle.fillet(handle_w / 2.0 - 1.0, handle.edges("|Z and <X"));
handle = handle.fillet(min(3.0, handle_t / 2.0 - 0.5), handle.edges("not |Z"));
let opener = handle + blade;
opener - cylinder([-handle_l + handle_w / 2.0, 0, -handle_t], "Z", 3.0, 2.0 * handle_t)
