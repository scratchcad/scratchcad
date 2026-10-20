// Dip pen rest for 3 pens: 90 x 25 x 15 mm block with three 12 mm V-notches 8 mm deep on 28 mm centres, 1 mm chamfered top and a 2 mm felt recess underneath
let pens = 3; // [1, 6] Number of pen notches
let pitch = 28.0; // [20.0, 35.0] Notch spacing (mm)
const h = 15.0;
let length = pitch * pens.to_float() + 6.0;
let b = box_from_corners([0, 0, 0], [length, 25.0, h]);
let b = b.chamfer(1.0, b.edges(">Z"));
let notches = [];
for i in 0..pens { let x = 3.0 + pitch * (i.to_float() + 0.5); notches.push(face(polygon([[x - 6.0, -1.0, h + 0.01], [x + 6.0, -1.0, h + 0.01], [x, -1.0, h - 8.0]])).extrude([0, 27.0, 0])); }
b - fuse_all(notches) - box_from_corners([3.0, 3.0, -1.0], [length - 3.0, 22.0, 2.0])
