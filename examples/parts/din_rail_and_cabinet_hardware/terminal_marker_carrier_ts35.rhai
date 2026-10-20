// Terminal block marker carrier for TS35 rail: 6 mm wide clip foot hooking under the 35 mm rail flanges, 45 mm stem and a 32 x 10 mm label holder head with a 28 x 6 mm marker slot 1 mm deep on each face
let height = 45.0; // [25.0, 70.0] Height of the head above the rail (mm)
let head_len = 32.0; // [20.0, 50.0] Label holder length (mm)
let head_h = 10.0; // [7.0, 16.0] Label holder height (mm)
const width = 6.0;
const lip = 2.3;
let foot = face(polygon([
    [0, -19.5, -lip], [0, -15.5, -lip], [0, -15.5, -1.2], [0, -17.7, -1.2], [0, -17.7, 0],
    [0, 17.7, 0], [0, 17.7, -1.2], [0, 15.5, -1.2], [0, 15.5, -lip], [0, 19.5, -lip],
    [0, 19.5, 5.0], [0, -19.5, 5.0]])).extrude([width, 0, 0]);
let stem = box_from_corners([0, -4.0, 4.0], [width, 4.0, height - head_h + 0.5]);
let head = box_from_corners([0, -head_len / 2.0, height - head_h], [width, head_len / 2.0, height]);
let slots = compound([
    box_from_corners([-1.0, -head_len / 2.0 + 2.0, height - head_h + 2.0], [1.0, head_len / 2.0 - 2.0, height - 2.0]),
    box_from_corners([width - 1.0, -head_len / 2.0 + 2.0, height - head_h + 2.0], [width + 1.0, head_len / 2.0 - 2.0, height - 2.0])]);
(foot + stem + head) - slots
