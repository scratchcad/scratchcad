// Under-desk headphone hook: 40 mm clamp for a 25 mm desk, 60 mm cradle 35 mm wide, M4 screw holes
let desk = 25.0; // [15.0, 40.0] Desk thickness (mm)
let cradle = 60.0; // [40.0, 90.0] Cradle reach (mm)
let width = 35.0; // [20.0, 50.0] Width (mm)
let t = 5.0; // [4.3, 8.0] Thickness (mm)
let profile = sketch("XZ").move_to(0, t).hline_to(40.0).vline_to(0).hline_to(t).vline_to(-desk).hline_to(cradle).vline_to(-desk - 15.0).hline_to(cradle - t).vline_to(-desk - t).hline_to(0).close();
let hook = profile.to_face().extrude([0, width, 0]);
hook = hook.fillet(2.0, "|Y");
hook - cylinder([25.0, width / 2.0, -1], "Z", 2.2, t + 2.0) - cylinder([25.0, width / 2.0, t - 2.0], "Z", 4.0, 3.0)
