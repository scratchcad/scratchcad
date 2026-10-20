// Swimming nose clip frame: 2 mm spring-wire style U frame 30 mm tall, 18 mm wide, with two 8 x 6 mm pads 3 mm thick facing each other 2 mm apart
let width = 18.0; // [14.0, 24.0] Frame width (mm)
let height = 30.0; // [22.0, 40.0] Frame height (mm)
const wire = 2.0;
const gap = 2.0;
let arms = box_from_corners([-width / 2.0, -wire / 2.0, 0], [-width / 2.0 + wire, wire / 2.0, height]) + box_from_corners([width / 2.0 - wire, -wire / 2.0, 0], [width / 2.0, wire / 2.0, height]);
let top = box_from_corners([-width / 2.0, -wire / 2.0, height - wire], [width / 2.0, wire / 2.0, height]);
let pads = box_from_corners([-width / 2.0 + wire - 0.01, -3.0, 0], [-gap / 2.0, 3.0, 8.0]) + box_from_corners([gap / 2.0, -3.0, 0], [width / 2.0 - wire + 0.01, 3.0, 8.0]);
arms + top + pads
