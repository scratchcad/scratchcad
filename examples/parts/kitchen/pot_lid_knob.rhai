// Saucepan lid knob: 45 mm mushroom top 30 mm tall on a 26 mm base, M5 screw bore with a captive 8 mm hex nut trap, finger groove under the top
let top_diameter = 45.0; // [30.0, 60.0] Top diameter (mm)
let base_diameter = 26.0; // [18.0, 35.0] Base diameter (mm)
let height = 30.0; // [20.0, 45.0] Knob height (mm)
let screw_diameter = 5.0; // [4.0, 6.0] Screw diameter (mm)
let nut_width = 8.0; // [7.0, 10.0] Nut across flats (mm)
let rt = top_diameter / 2.0;
let rb = base_diameter / 2.0;
let neck = rb * 0.75;
let p = sketch("XZ").move_to(0, 0).hline_to(rb).arc_to(neck + 1.0, height * 0.35, neck, height * 0.55)
    .line_to(rt - 3.0, height * 0.66).arc_to(rt, height * 0.8, rt - 4.0, height * 0.95).arc_to(rt * 0.5, height * 1.0, 0, height).close();
let knob = p.to_face().revolve("Z", 360);
knob -= cylinder([0, 0, -1.0], "Z", screw_diameter / 2.0 + 0.2, height * 0.7);
let rc = nut_width / sqrt(3.0);
let hex = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; hex.push([rc * a.cos(), rc * a.sin()]); }
knob - polygon(hex).to_face().extrude([0, 0, 5.0]).translate([0, 0, height * 0.7 - 5.0])
