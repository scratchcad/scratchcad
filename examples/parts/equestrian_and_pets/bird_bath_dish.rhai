// Bird bath dish: 400 mm, 50 mm deep, graduated 20 mm and 50 mm depths, 8 mm wall, 50 mm spigot to a pedestal
let diameter = 400.0; // [250.0, 600.0] Dish diameter (mm)
let depth = 50.0; // [30.0, 80.0] Max water depth (mm)
let wall = 8.0; // [5.0, 12.0] Wall (mm)
let r = diameter / 2.0;
let p = sketch("XZ").move_to(0, -wall).hline_to(r * 0.35).line_to(r, depth - 5.0).vline_to(depth + 5.0).hline_to(r - wall).line_to(r * 0.6, 30.0).hline_to(r * 0.35).line_to(0, 0).close();
let dish = p.face().revolve("Z", 360);
dish + cylinder([0, 0, -wall - 50.0], "Z", 25.0, 50.01)
