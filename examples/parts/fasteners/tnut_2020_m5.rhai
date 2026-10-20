// Drop-in T-nut for 2020 6 mm slot, M5: 10 x 6 x 4.5 mm body with a 6 mm wide neck
let length = 10.0; // [8.0, 20.0] Length (mm)
let width = 10.0; // [8.0, 11.0] Wing width (mm)
let neck = 5.8; // [5.0, 6.2] Neck width (mm)
let bore = 4.2; // [2.5, 5.0] Tap hole (mm)
let wings = sketch("YZ").move_to(-width / 2.0, 1.8).line_to(-neck / 2.0, 0).hline_to(neck / 2.0).line_to(width / 2.0, 1.8)
    .vline_to(2.8).hline_to(-width / 2.0).close().to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let lip = box_centered(length, neck, 1.7).translate([0, 0, 2.8 + 0.85]);
(wings + lip) - cylinder([0, 0, -1], "Z", bore / 2.0, 8.0)
