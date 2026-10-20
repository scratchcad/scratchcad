// Stick shuttle for weaving: 300 x 30 x 5 mm with 15 mm deep notched ends and rounded corners
let length = 300.0; // [200.0, 450.0] Length (mm)
let width = 30.0; // [20.0, 45.0] Width (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let notch = 15.0; // [8.0, 25.0] End notch depth (mm)
let s = box_from_corners([0, 0, 0], [length, width, t]);
let ss = s.fillet(4.0, s.edges("|Z"));
let n1 = box_from_corners([-1, width / 2.0 - 4.0, -1], [notch, width / 2.0 + 4.0, t + 1.0]);
let n2 = box_from_corners([length - notch, width / 2.0 - 4.0, -1], [length + 1.0, width / 2.0 + 4.0, t + 1.0]);
ss - n1.fillet(3.9, n1.edges("|Z and >X")) - n2.fillet(3.9, n2.edges("|Z and <X"))
