// TS35 DIN rail end stop with screw clamp: 9 mm wide, 40 mm tall wedge body that hooks under the 35 mm rail flanges (1 mm thick), M4 clamp screw down the middle with a 7 mm hex nut slot
let width = 9.0; // [8.0, 14.0] Width along the rail (mm)
let height = 40.0; // [28.0, 55.0] Height above the rail (mm)
let top_width = 12.0; // [10.0, 20.0] Width of the top (mm)
const lip = 2.3;
let half_top = top_width / 2.0;
let profile = polygon([
    [0, -19.5, -lip], [0, -15.5, -lip], [0, -15.5, -1.2], [0, -17.7, -1.2], [0, -17.7, 0],
    [0, 17.7, 0], [0, 17.7, -1.2], [0, 15.5, -1.2], [0, 15.5, -lip], [0, 19.5, -lip],
    [0, 19.5, 8.0], [0, half_top, height], [0, -half_top, height], [0, -19.5, 8.0]]);
let body = face(profile).extrude([width, 0, 0]);
let screw = cylinder([width / 2.0, 0, -1.0], "Z", 2.1, height + 2.0);
let nut = box_from_corners([width / 2.0 - 4.05, -3.5, 9.0], [width + 1.0, 3.5, 12.4]);
let head = cylinder([width / 2.0, 0, height - 4.0], "Z", 3.8, 5.0);
body - screw - nut - head
