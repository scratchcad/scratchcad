// Webbing keeper: elastic-strap keeper loop for 45 mm webbing doubled (2 x 2.5 mm), 50 x 8 mm opening, 2 mm wall, 12 mm wide band with a grip rib
let webbing = 45.0; // [20.0, 50.0] Webbing width (mm)
let stack = 6.0; // [3.0, 12.0] Webbing stack thickness (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let band = 12.0; // [8.0, 20.0] Band width (mm)
let iw = webbing + 4.0;
let ih = stack + 2.0;
let outer = box_centered(iw + 2.0 * wall, ih + 2.0 * wall, band);
let o = outer.fillet(wall + 1.0, outer.edges("|Z"));
let inner = box_centered(iw, ih, band + 2.0);
let i = inner.fillet(1.0, inner.edges("|Z"));
let rib = box_centered(iw * 0.6, 1.0, band).translate([0, -ih / 2.0 + 0.4, 0]);
o - i + rib
