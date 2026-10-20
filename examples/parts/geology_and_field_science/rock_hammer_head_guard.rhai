// Rock hammer head guard: sheath for a 28 x 28 mm square face and 120 mm pick, 2.5 mm walls, open top slot 20 mm wide for the handle and a belt loop 40 x 8 mm
let face_w = 28.0; // [22.0, 35.0] Hammer face size (mm)
let pick = 120.0; // [90.0, 160.0] Head length (mm)
const wall = 2.5;
let outer = box_from_corners([-wall, -face_w / 2.0 - wall, -wall], [pick + wall, face_w / 2.0 + wall, face_w + wall]);
let inner = box_from_corners([0, -face_w / 2.0, 0], [pick, face_w / 2.0, face_w + 5.0]);
let slot = box_from_corners([pick / 2.0 - 10.0, -face_w, face_w - 1.0], [pick / 2.0 + 10.0, face_w, face_w + 10.0]);
let loop_ = box_from_corners([pick / 2.0 - 25.0, face_w / 2.0 + wall - 0.01, 0], [pick / 2.0 + 25.0, face_w / 2.0 + wall + 10.0, face_w]) - box_from_corners([pick / 2.0 - 20.0, face_w / 2.0 + wall + 2.0, -1.0], [pick / 2.0 + 20.0, face_w / 2.0 + wall + 8.0, face_w + 1.0]);
outer - inner - slot + loop_
