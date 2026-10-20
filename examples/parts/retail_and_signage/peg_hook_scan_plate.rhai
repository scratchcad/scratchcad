// Peg hook scan plate (label holder) for 4.8 mm wire: 39 x 25 mm face, 1.2 mm, clips over the wire with a 4.8 mm snap channel
let w = 39.0; // [30.0, 60.0] Face width (mm)
let h = 25.0; // [20.0, 40.0] Face height (mm)
let wire = 4.8; // [3.5, 6.5] Wire diameter (mm)
let face = box_centered(w, 1.2, h);
let f = face.fillet(2.0, face.edges("|Y"));
let clip = cylinder([0, 0.6, h / 2.0 - wire / 2.0 - 1.5], "X", wire / 2.0 + 1.5, 14.0).translate([-7.0, wire / 2.0 + 0.9, 0]) - cylinder([-8.0, 0.6 + wire / 2.0 + 0.9, h / 2.0 - wire / 2.0 - 1.5], "X", wire / 2.0, 16.0) - box_from_corners([-8.0, 0.6 + wire / 2.0 + 0.9 - 1.5, h / 2.0 - wire - 4.0], [8.0, 0.6 + wire / 2.0 + 0.9 + 1.5, h / 2.0 - wire / 2.0 - 1.5]);
f + clip
