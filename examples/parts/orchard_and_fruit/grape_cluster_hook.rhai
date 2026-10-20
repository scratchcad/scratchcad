// Grape bunch support hook: 4 mm round-bar style S-hook about 70 mm overall, top hook 12 mm opening for the training wire, bottom 20 mm cradle for the stem, flat 4 x 4 section
let length = 60.0; // [40.0, 90.0] Overall length (mm)
let cradle = 20.0; // [12.0, 30.0] Lower cradle opening (mm)
const s = 4.0;
let top = (cylinder([0, 0, 0], "Y", 6.0 + s, s) - cylinder([0, -1.0, 0], "Y", 6.0, s + 2.0)) - box_from_corners([0, -1.0, -20.0], [20.0, s + 1.0, 0.0]);
let shank = box_from_corners([-6.0 - s, 0, -length + cradle / 2.0 + s], [-6.0, s, 0.01]);
let rc = cradle / 2.0;
let bot = ((cylinder([-6.0 - s + rc + s, 0, -length + rc + s], "Y", rc + s, s) - cylinder([-6.0 - s + rc + s, -1.0, -length + rc + s], "Y", rc, s + 2.0)) - box_from_corners([-50.0, -1.0, -length + rc + s], [50.0, s + 1.0, 10.0]));
top + shank + bot
