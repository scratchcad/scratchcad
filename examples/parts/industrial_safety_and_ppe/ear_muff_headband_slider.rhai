// Ear muff headband slider: 22 x 12 x 30 mm block with a 16 x 4 mm band passage, 6 adjustment detent ribs and a 6 mm cup yoke pivot pin 8 mm long on one side
let width = 22.0; // [16.0, 30.0] Slider width (mm)
let thickness = 12.0; // [8.0, 16.0] Slider thickness (mm)
let length = 30.0; // [20.0, 45.0] Slider length (mm)
let band_width = 16.0; // [10.0, 24.0] Headband width (mm)
let band_thickness = 4.0; // [2.0, 6.0] Headband thickness (mm)
let body = box_centered(width, thickness, length).translate([0, 0, length / 2.0]);
let b = body.fillet(2.5, body.edges("|Z"));
let passage = box_centered(band_width, band_thickness, length + 2.0).translate([0, 0, length / 2.0]);
let ribs = [];
for i in 0..6 { ribs.push(box_centered(band_width - 4.0, 0.8, 1.2).translate([0, band_thickness / 2.0 - 0.3, 4.0 + i.to_float() * 4.0])); }
// the cup yoke pivot pin stands out of one side wall
let pin = cylinder([width / 2.0 - 0.5, 0, length / 2.0], "X", 3.0, 8.5);
b - passage + fuse_all(ribs) + pin.chamfer(0.5, pin.edges(">X"))
