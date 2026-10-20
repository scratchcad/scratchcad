// Arrow shaft cut-off V-block: 60 x 30 x 25 mm block with a 90 degree V groove 8 mm deep, 1 mm saw slot 3 mm in from one end and a 40 mm adjustable stop slot
let length = 60.0; // [40.0, 90.0] Block length (mm)
let v_depth = 8.0; // [5.0, 10.0] V groove depth (mm)
const width = 30.0;
const height = 25.0;
let block = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let v = face(polygon([[-1.0, -v_depth, height + 0.01], [-1.0, v_depth, height + 0.01], [-1.0, 0, height - v_depth]])).extrude([length + 2.0, 0, 0]);
let saw = box_from_corners([3.0, -width, height - v_depth - 4.0], [4.0, width, height + 1.0]);
let stop = box_from_corners([12.0, -2.1, -1.0], [length - 8.0, 2.1, height - v_depth - 2.0]);
block - v - saw - stop
