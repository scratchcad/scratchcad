// Music stand page clip: clips over a 2 mm stand desk edge, 40 mm wide spring clip 1.6 mm thick with a 25 mm transparent-style page arm and a 3 mm finger lift
let desk = 2.0; // [1.0, 5.0] Stand desk thickness (mm)
let arm = 25.0; // [15.0, 40.0] Page arm length (mm)
const t = 1.6;
const w = 40.0;
let back = box_from_corners([0, 0, 0], [t, w, 30.0]);
let top = box_from_corners([0, 0, 30.0 - t], [2.0 * t + desk, w, 30.0]);
let front = box_from_corners([t + desk, 0, 30.0 - arm], [2.0 * t + desk, w, 30.0]);
let lift = box_from_corners([t + desk, 0, 30.0 - arm], [2.0 * t + desk + 3.0, w, 30.0 - arm + t]);
back + top + front + lift
