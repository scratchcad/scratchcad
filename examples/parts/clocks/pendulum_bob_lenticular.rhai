// Lenticular pendulum bob: 80 mm diameter, 16 mm thick lens, 6 x 2 mm rod slot through, rating nut seat 8 mm
let diameter = 80.0; // [50.0, 120.0] Bob diameter (mm)
let thickness = 16.0; // [10.0, 25.0] Centre thickness (mm)
let rod_w = 6.0; // [4.0, 10.0] Rod width (mm)
let rs = (diameter * diameter / 4.0 + thickness * thickness / 4.0) / thickness;
let lens = sphere([0, thickness / 2.0 - rs, 0], rs) & sphere([0, -thickness / 2.0 + rs, 0], rs);
lens - box_centered(rod_w, 2.2, diameter + 10.0) - cylinder([0, 0, -diameter / 2.0 - 1.0], "Z", 4.0, 6.0)
