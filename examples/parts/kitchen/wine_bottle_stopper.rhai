// Wine bottle stopper: tapered plug 17.5 to 21 mm over 26 mm with three sealing fins 1 mm proud, 6 mm neck to a 34 mm mushroom knob 14 mm tall
let plug_length = 26.0; // [15.0, 40.0] Plug length (mm)
let tip_diameter = 17.5; // [14.0, 20.0] Plug tip diameter (mm)
let top_diameter = 21.0; // [17.0, 25.0] Plug top diameter (mm)
let fin_count = 3; // [0, 5] Number of sealing fins
let knob_diameter = 34.0; // [24.0, 50.0] Knob diameter (mm)
let knob_height = 14.0; // [8.0, 25.0] Knob height (mm)
let r0 = tip_diameter / 2.0;
let r1 = max(top_diameter / 2.0, r0);
let rk = knob_diameter / 2.0;
let p = sketch("XZ").move_to(0, 0).hline_to(r0 - 0.8).line_to(r0, 0.8).line_to(r1, plug_length).hline_to(7.0).vline(6.0).line_to(rk, plug_length + 9.0)
    .arc_to(rk * 0.8, plug_length + 6.0 + knob_height * 0.8, 0, plug_length + 6.0 + knob_height).close();
let stopper = p.to_face().revolve("Z", 360);
for i in 0..fin_count {
    let z = plug_length * (i + 1).to_float() / (fin_count + 1).to_float();
    let rz = r0 + (r1 - r0) * z / plug_length;
    stopper += torus(rz - 0.2, 1.2).translate([0, 0, z]);
}
stopper
