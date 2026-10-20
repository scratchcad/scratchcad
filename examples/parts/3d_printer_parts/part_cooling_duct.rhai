// 5015 blower part-cooling duct: 20 x 15 mm inlet lofted down and around to a 30 x 3 mm slot outlet, 1.2 mm walls
let inlet_w = 20.0; // [15.0, 25.0] Inlet width (mm)
let inlet_h = 15.0; // [10.0, 20.0] Inlet height (mm)
let outlet_w = 30.0; // [15.0, 50.0] Outlet width (mm)
let outlet_h = 3.0; // [2.0, 6.0] Outlet height (mm)
let drop = 25.0; // [15.0, 40.0] Drop (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let a = rect(plane([0, 0, drop], "Z"), inlet_w, inlet_h);
let b = rect(plane([0, 4.0, drop * 0.5], [0, 0.3, 1]), inlet_w * 1.1, inlet_h * 0.6);
let c = rect(plane([0, 12.0, 0], [0, 1, 0.5]), outlet_w, outlet_h);
let outer = loft([a, b, c], true);
// hollow it with a loft of the same sections less the walls, run 1 mm past both open ends
let n = vec3(0.0, 1.0, 0.5).normalize();
let ai = rect(plane([0, 0, drop + 1.0], "Z"), inlet_w - 2.0 * wall, inlet_h - 2.0 * wall);
let bi = rect(plane([0, 4.0, drop * 0.5], [0, 0.3, 1]), inlet_w * 1.1 - 2.0 * wall, inlet_h * 0.6 - 2.0 * wall);
let ci = rect(plane(vec3(0.0, 12.0, 0.0) + n, [0, 1, 0.5]), outlet_w - 2.0 * wall, outlet_h - 2.0 * wall);
outer - loft([ai, bi, ci], true)
