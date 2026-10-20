// Baseball bat knob end: 25 mm handle 90 mm long flaring into a 52 mm knob 11 mm thick with a rounded rim and a 2 mm cupped end
let handle_d = 25.0; // [20.0, 32.0] Handle diameter (mm)
let handle_length = 90.0; // [40.0, 150.0] Handle length (mm)
let knob_d = 52.0; // [40.0, 65.0] Knob diameter (mm)
let knob_t = 11.0; // [7.0, 16.0] Knob thickness (mm)
let cup = 2.0; // [0.0, 4.0] End cup depth (mm)
let rh = handle_d / 2.0;
let rk = max(knob_d / 2.0, rh + 6.0);
const flare = 14.0;
let prof = sketch("XZ").move_to(0, cup).hline_to(rk - 6.0).line_to(rk - 3.0, 0.0).hline_to(rk - 2.0).arc_to(rk - 0.586, 0.586, rk, 2.0).vline_to(knob_t * 0.5)
    .line_to(rk - 2.0, knob_t).arc_to(rh + 3.5, knob_t + 2.5, rh, knob_t + flare).vline_to(knob_t + flare + handle_length).hline_to(0).close();
prof.to_face().revolve("Z", 360)
