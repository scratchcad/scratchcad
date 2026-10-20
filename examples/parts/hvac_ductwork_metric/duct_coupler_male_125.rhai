// 125 mm male-male duct connector: 124 mm OD sleeve 100 mm long, 1.5 mm wall, central 6 mm stop ring 3 mm proud, two 2 mm seal grooves 12 mm from each end
let duct_d = 124.0; // [80.0, 250.0] Sleeve outside diameter (mm)
let length = 100.0; // [60.0, 200.0] Overall length (mm)
let wall = 1.5; // [1.2, 3.0] Wall thickness (mm)
let stop_h = 3.0; // [1.5, 6.0] Stop ring height (mm)
const stop_w = 6.0;
const groove_w = 2.0;
let ro = duct_d / 2.0;
let ri = ro - wall;
let gd = wall * 0.4;
let zm = length / 2.0;
let prof = polygon([
    [ri, 0, 0], [ro, 0, 0],
    [ro, 0, 12.0], [ro - gd, 0, 12.0], [ro - gd, 0, 12.0 + groove_w], [ro, 0, 12.0 + groove_w],
    [ro, 0, zm - stop_w / 2.0], [ro + stop_h, 0, zm - stop_w / 2.0 + 1.0], [ro + stop_h, 0, zm + stop_w / 2.0 - 1.0], [ro, 0, zm + stop_w / 2.0],
    [ro, 0, length - 12.0 - groove_w], [ro - gd, 0, length - 12.0 - groove_w], [ro - gd, 0, length - 12.0], [ro, 0, length - 12.0],
    [ro, 0, length], [ri, 0, length]]);
prof.to_face().revolve("Z", 360)
