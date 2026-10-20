// Bandsaw / table saw push stick: 300 mm long, 12 mm thick, 60 mm tall, 10 mm hooked heel 25 mm long, 80 x 14 mm hand slot
let length = 300.0; // [200.0, 400.0] Length (mm)
let height = 60.0; // [40.0, 90.0] Height (mm)
let t = 12.0; // [9.0, 19.0] Thickness (mm)
let heel = 10.0; // [5.0, 20.0] Heel drop (mm)
let heel_l = 25.0; // [15.0, 40.0] Heel length (mm)
let pts = [[0, heel, 0], [length - heel_l - 5.0, heel, 0], [length - heel_l - 5.0, 0, 0], [length - 5.0, 0, 0], [length, heel * 0.8, 0], [length, height * 0.55, 0], [length - 80.0, height, 0], [0, height * 0.75, 0]];
let stick = polygon(pts).to_face().extrude([0, 0, t]);
let sx = length * 0.25;
let sy = heel + (height * 0.75 - heel) / 2.0;
let slot = box_from_corners([sx, sy - 7.0, -1], [sx + 66.0, sy + 7.0, t + 1.0]) + cylinder([sx, sy, -1], "Z", 7.0, t + 2.0) + cylinder([sx + 66.0, sy, -1], "Z", 7.0, t + 2.0);
stick - slot
