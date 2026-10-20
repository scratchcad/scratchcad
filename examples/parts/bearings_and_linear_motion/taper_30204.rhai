// 30204 tapered roller bearing: 20 mm bore, 47 mm OD, 15.25 mm wide, cone and cup with 15 rollers
let bore = 20.0; // [15.0, 40.0] Bore (mm)
let outer = 47.0; // [35.0, 80.0] Outside diameter (mm)
let width = 15.25; // [12.0, 22.0] Overall width (mm)
let rollers = 15; // [12, 19] Number of rollers
let mid_r = (bore + outer) / 4.0;
let cup = sketch("XZ").move_to(mid_r + 1.5, 0.5).line_to(mid_r + 3.5, width - 1.0).hline_to(outer / 2.0).vline_to(0.5).close().to_face().revolve("Z", 360);
let cone_race = sketch("XZ").move_to(bore / 2.0, 0).hline_to(mid_r - 3.0).line_to(mid_r - 1.0, width - 1.5).hline_to(mid_r - 0.5).vline_to(width).hline_to(bore / 2.0).close().to_face().revolve("Z", 360);
let roller = cone(2.6, 3.2, width - 4.0).rotate_y(-6).translate([mid_r, 0, 1.6]);
let parts = [cup, cone_race];
for i in 0..rollers { parts.push(roller.rotate_z(i * 360.0 / rollers.to_float())); }
compound(parts)
