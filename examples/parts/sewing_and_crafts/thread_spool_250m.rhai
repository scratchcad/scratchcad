// Thread spool for 250 m polyester: 52 mm tall, 30 mm flanges, 22 mm barrel, 9 mm pin bore, thread notch
let height = 52.0; // [35.0, 70.0] Height (mm)
let flange_d = 30.0; // [20.0, 40.0] Flange diameter (mm)
let barrel_d = 22.0; // [14.0, 30.0] Barrel diameter (mm)
let bore = 9.0; // [5.0, 12.0] Pin bore (mm)
let lip = 2.5; // [1.5, 4.0] Flange thickness (mm)
let profile = sketch("XZ").move_to(bore / 2.0, 0).hline_to(flange_d / 2.0).vline_to(lip).line_to(barrel_d / 2.0, lip + 3.0).vline_to(height - lip - 3.0).line_to(flange_d / 2.0, height - lip).vline_to(height).hline_to(bore / 2.0).close();
let spool = profile.face().revolve("Z", 360);
spool - box_from_corners([flange_d / 2.0 - 3.0, -0.4, height - lip - 0.1], [flange_d / 2.0 + 1.0, 0.4, height + 1.0])
