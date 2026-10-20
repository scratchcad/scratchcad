// Classic rolling pin: 50 mm barrel 250 mm long with rounded ends, 25 mm handles 90 mm long with a waist and knob ends, 430 mm overall
let barrel_diameter = 50.0; // [40.0, 70.0] Barrel diameter (mm)
let barrel_length = 250.0; // [150.0, 450.0] Barrel length (mm)
let handle_diameter = 25.0; // [18.0, 35.0] Handle diameter (mm)
let handle_length = 90.0; // [60.0, 130.0] Handle length (mm)
let rb = barrel_diameter / 2.0;
let rh = min(handle_diameter / 2.0, rb - 6.0);
let b = barrel_length / 2.0;
let e = b + handle_length;
// profile along X, revolved about the X axis
let p = sketch("XY").move_to(0, 0).vline_to(rb).hline_to(b - 4.0).arc_to(b - 1.2, rb - 1.2, b, rb - 4.0).vline_to(rh * 0.8).hline_to(b + 6.0)
    .arc_to(b + handle_length * 0.5, rh * 0.85, e - 12.0, rh).arc_to(e - 3.0, rh + 1.5, e, rh * 0.5).vline_to(0).close();
let half = p.to_face().revolve("X", 360);
half + half.mirror("YZ")
