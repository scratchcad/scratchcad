// Small-pet hide house: 140 x 100 mm footprint, 90 mm tall gable house with 3 mm walls, a 55 mm arched-top doorway (straight-segment arch), two 20 mm windows and open base
let width = 140.0; // [100.0, 200.0] House width (mm)
let door = 55.0; // [40.0, 75.0] Doorway width (mm)
const depth = 100.0;
const wall = 3.0;
const eave = 60.0;
const ridge = 90.0;
let prof = polygon([[0, 0, 0], [width, 0, 0], [width, 0, eave], [width / 2.0, 0, ridge], [0, 0, eave]]);
let outer = face(prof).extrude([0, depth, 0]);
let iprof = polygon([[wall, 0, -1.0], [width - wall, 0, -1.0], [width - wall, 0, eave - 1.0], [width / 2.0, 0, ridge - wall * 1.6], [wall, 0, eave - 1.0]]);
let inner = face(iprof).extrude([0, depth - 2.0 * wall, 0]).translate([0, wall, 0]);
let dw = door / 2.0;
let doorway = face(polygon([[width / 2.0 - dw, -1.0, -1.0], [width / 2.0 + dw, -1.0, -1.0], [width / 2.0 + dw, -1.0, 35.0], [width / 2.0 + dw * 0.5, -1.0, 35.0 + dw * 0.7], [width / 2.0 - dw * 0.5, -1.0, 35.0 + dw * 0.7], [width / 2.0 - dw, -1.0, 35.0]])).extrude([0, wall + 2.0, 0]);
let windows = cylinder([-1.0, depth / 2.0, 35.0], "X", 10.0, width + 2.0);
outer - inner - doorway - windows
