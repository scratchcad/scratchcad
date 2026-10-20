// Round bench dog for 19 mm holes: 19 mm shank 80 mm long with a sprung brass flat, 25 mm head 12 mm tall with a flat clamping face
let hole = 19.0; // [16.0, 25.0] Bench hole diameter (mm)
let dog = cylinder(hole / 2.0 - 0.1, 80.0).chamfer(1.0, "<Z") + cylinder([0, 0, 80.0], "Z", hole / 2.0 + 3.0, 12.0);
dog -= box_from_corners([hole / 2.0 - 2.0, -20.0, 79.0], [hole, 20.0, 93.0]);
dog -= box_from_corners([hole / 2.0 - 1.5, -3.0, 20.0], [hole, 3.0, 60.0]);
dog + box_from_corners([hole / 2.0 - 1.5, -2.5, 25.0], [hole / 2.0 + 0.2, 2.5, 55.0])
