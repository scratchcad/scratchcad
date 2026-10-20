// US fin box nut insert: 22 x 9 x 6 mm slider with an M5 (#8-32) captive nut pocket 8 mm hex and 5.2 mm screw bore
let length = 22.0; // [15.0, 30.0] Slider length (mm)
let width = 9.0; // [7.0, 12.0] Slider width (mm)
let t = 6.0; // [4.0, 8.0] Slider thickness (mm)
let slider = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let s = slider.chamfer(0.8, slider.edges("|X"));
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([8.0 / 3.0.sqrt() * a.cos(), 8.0 / 3.0.sqrt() * a.sin()]); }
let nut = polygon(pts).to_face().extrude([0, 0, 4.0]).translate([0, 0, -0.01]);
let lips = box_centered(length, width + 3.0, 1.5).translate([0, 0, t - 0.75]);
s + lips - nut - cylinder([0, 0, -1], "Z", 2.6, t + 2.0)
