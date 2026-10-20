// Screen printing registration pin: 1/4 inch (6.35 mm) round pin 4 mm tall on a 25 x 10 mm tab 1.5 mm thick with a 6.35 mm half-round notch partner at the far end
let pin_d = 6.35; // [4.0, 8.0] Pin diameter (mm)
let pin_h = 4.0; // [2.0, 6.0] Pin height (mm)
const t = 1.5;
let tab = box_from_corners([0, -5.0, 0], [25.0, 5.0, t]);
let tab = tab.fillet(2.0, tab.edges("|Z"));
let pin = cylinder([6.0, 0, t - 0.01], "Z", pin_d / 2.0, pin_h);
let pin = pin.chamfer(0.4, pin.edges(">Z"));
tab + pin - cylinder([25.0, 0, -1.0], "Z", pin_d / 2.0, t + 2.0)
