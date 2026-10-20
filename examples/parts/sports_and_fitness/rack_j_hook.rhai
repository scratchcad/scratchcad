// Power rack J-hook for 3 x 3 in uprights: 76 mm wide x 150 mm tall 6 mm back plate, 70 mm deep bar cradle with a 35 mm front lip, 3 mm UHMW liner pad, 16 mm locating pin 45 mm long
let upright = 76.0; // [50.0, 80.0] Upright width (mm)
let plate_height = 150.0; // [100.0, 200.0] Back plate height (mm)
let cradle_depth = 70.0; // [50.0, 100.0] Cradle depth (mm)
let lip_height = 35.0; // [20.0, 60.0] Front lip height (mm)
let pin_d = 16.0; // [12.0, 25.4] Locating pin diameter (mm)
const t = 6.0;
const pin_len = 45.0;
const cz = 50.0;
let w = upright;
let plate = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, t, plate_height]);
let side = sketch("YZ").move_to(t - 0.5, cz).hline_to(t + cradle_depth + t).vline_to(cz + t + lip_height).hline(-t).vline_to(cz + t).hline_to(t - 0.5).close();
let cradle = side.to_face().extrude([w / 2.0 - 8.0, 0, 0]).translate([-(w / 2.0 - 8.0) / 2.0, 0, 0]);
let liner = box_from_corners([-(w / 2.0 - 8.0) / 2.0, t, cz + t - 0.01], [(w / 2.0 - 8.0) / 2.0, t + cradle_depth, cz + t + 3.0]);
let gusset = sketch("YZ").move_to(t - 0.5, cz).hline_to(t + cradle_depth * 0.6).line_to(t - 0.5, cz - cradle_depth * 0.5).close().to_face().extrude([t, 0, 0]).translate([-t / 2.0, 0, 0]);
let pin = cylinder([0, 0.5, plate_height - 30.0], "-Y", pin_d / 2.0, pin_len + 0.5).chamfer(1.5, "<Y");
let hook = fuse_all([plate, cradle, liner, gusset, pin]);
hook.fillet(5.0, hook.edges("|Y").filter(|e| e.center().z > plate_height - 0.1 || e.center().z < 0.1))
