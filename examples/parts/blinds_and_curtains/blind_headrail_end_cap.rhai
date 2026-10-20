// Venetian blind headrail end cap for 25 x 25 mm U rail: 2 mm cap, 8 mm plug, 3 mm cord exit hole
let w = 25.0; // [20.0, 40.0] Rail width (mm)
let h = 25.0; // [20.0, 40.0] Rail height (mm)
let cap = box_centered(w + 1.0, 2.0, h + 1.0);
let c = cap.fillet(1.5, cap.edges("|Y and >Z"));
let plug = (box_centered(w - 2.4, 8.0, h - 2.4) - box_centered(w - 6.0, 9.0, h - 4.0).translate([0, 0, 1.0])).translate([0, 4.99, 0]);
c + plug - cylinder([0, -2, -h / 2.0 + 6.0], "Y", 1.5, 14.0)
