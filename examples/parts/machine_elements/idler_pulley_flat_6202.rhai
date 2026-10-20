// Flat-belt idler pulley for a 6202 bearing: 35 mm bearing bore with 1 mm retaining shoulder, 60 mm crowned face (0.5 mm crown), 66 mm flanges, 30 mm wide
let bearing_od = 35.0; // [16.0, 62.0] Bearing outer diameter (mm)
let face_diameter = 60.0; // [30.0, 120.0] Belt face diameter (mm)
let flange_diameter = 66.0; // [32.0, 130.0] Flange diameter (mm)
let width = 30.0; // [12.0, 60.0] Overall width (mm)
let crown = 0.5; // [0.0, 1.5] Crown height (mm)
const flange = 2.5;
let rb = bearing_od / 2.0;
let rf = max(face_diameter / 2.0, rb + 4.0);
let rfl = max(flange_diameter / 2.0, rf + 1.0);
let profile = sketch("XZ")
    .move_to(rb, 0.0)
    .hline_to(rfl).vline(flange).hline_to(rf)
    .arc_to(rf + crown + 0.001, width / 2.0, rf, width - flange)
    .hline_to(rfl).vline_to(width).hline_to(rb)
    .vline_to(width / 2.0 + 1.0).hline(-1.0).vline(-2.0).hline(1.0)
    .close();
let pulley = profile.to_face().revolve("Z", 360);
pulley.chamfer(0.4, "%CIRCLE and (>Z or <Z)")
