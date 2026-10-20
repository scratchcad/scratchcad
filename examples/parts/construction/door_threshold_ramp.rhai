// Door threshold ramp: 900 mm wide, 25 mm rise over 150 mm run with a 10 mm flat lip, 6 grip grooves, hollow underside
let width = 900.0; // [600.0, 1200.0] Width (mm)
let rise = 25.0; // [10.0, 60.0] Rise (mm)
let run = 150.0; // [80.0, 300.0] Run (mm)
let ramp = polygon([[0, 0, 0], [run + 10.0, 0, 0], [run + 10.0, 0, rise], [run, 0, rise], [0, 0, 2.0]]).to_face().extrude([0, width, 0]);
for k in 1..7 { let x = run * k.to_float() / 7.0; ramp -= cylinder([x, -1, 2.0 + (rise - 2.0) * x / run], "Y", 1.5, width + 2.0); }
ramp - polygon([[15.0, 0, -0.01], [run - 5.0, 0, -0.01], [run - 5.0, 0, rise * 0.75], [15.0, 0, 0.5]]).to_face().extrude([0, width - 40.0, 0]).translate([0, 20.0, 0])
