// Insulated DIN rail support for a 6 x 9 mm neutral / PE terminal bar: 12 mm wide clip foot on the TS35 rail's 35 mm flanges, 20 mm tall pedestal and a 6.2 x 9.2 mm pocket through the head with an M4 (3.3 mm) locking screw hole from the top
let height = 20.0; // [12.0, 40.0] Bar height above the rail (mm)
let bar_w = 6.0; // [5.0, 10.0] Bar thickness (mm)
let bar_h = 9.0; // [6.0, 12.0] Bar height (mm)
const width = 12.0;
const lip = 2.3;
let foot = face(polygon([
    [0, -19.5, -lip], [0, -15.5, -lip], [0, -15.5, -1.2], [0, -17.7, -1.2], [0, -17.7, 0],
    [0, 17.7, 0], [0, 17.7, -1.2], [0, 15.5, -1.2], [0, 15.5, -lip], [0, 19.5, -lip],
    [0, 19.5, 4.0], [0, -19.5, 4.0]])).extrude([width, 0, 0]);
let head_top = height + bar_h / 2.0 + 4.0;
let ped = face(polygon([[0, -14.0, 3.5], [0, 14.0, 3.5], [0, 8.0, 10.0], [0, 8.0, head_top], [0, -8.0, head_top], [0, -8.0, 10.0]])).extrude([width, 0, 0]);
let pocket = box_from_corners([-1.0, -bar_w / 2.0 - 0.1, height - bar_h / 2.0 - 0.1], [width + 1.0, bar_w / 2.0 + 0.1, height + bar_h / 2.0 + 0.1]);
let screw = cylinder([width / 2.0, 0, height], "Z", 1.65, head_top);
foot + ped - pocket - screw
