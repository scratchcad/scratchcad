// Sewing machine foot controller top cover: 110 x 90 mm footprint, sloping from 22 mm at the toe to 45 mm at the heel, 2.5 mm walls, open underneath, 40 x 12 mm cable notch in the heel wall
let length = 110.0; // [90.0, 140.0] Cover length (mm)
let width = 90.0; // [70.0, 120.0] Cover width (mm)
let toe_h = 22.0; // [15.0, 30.0] Toe height (mm)
let heel_h = 45.0; // [35.0, 60.0] Heel height (mm)
const wall = 2.5;
let outer = polygon([[0, 0, 0], [length, 0, 0], [length, 0, toe_h], [0, 0, heel_h]]).to_face().extrude([0, width, 0]);
let t = wall * sqrt(1.0 + ((heel_h - toe_h) / length) * ((heel_h - toe_h) / length));
let inner = polygon([[wall, 0, -1.0], [length - wall, 0, -1.0], [length - wall, 0, toe_h - t + (heel_h - toe_h) * wall / length], [wall, 0, heel_h - t - (heel_h - toe_h) * wall / length]]).to_face().extrude([0, width - 2.0 * wall, 0]).translate([0, wall, 0]);
let notch = box_from_corners([-1.0, width / 2.0 - 20.0, -1.0], [wall + 1.0, width / 2.0 + 20.0, 12.0]);
outer - inner - notch
