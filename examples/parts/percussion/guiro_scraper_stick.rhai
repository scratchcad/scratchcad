// Guiro scraper: 150 mm stick 8 mm, 3 tines 25 mm on a 30 mm head, 20 mm ball end
let length = 150.0; // [100.0, 200.0] Stick length (mm)
let d = 8.0; // [6.0, 12.0] Stick diameter (mm)
let stick = cylinder([0, 0, 0], "X", d / 2.0, length) + sphere([0, 0, 0], 10.0);
let head = box_from_corners([length - 0.01, -15.0, -2.0], [length + 5.0, 15.0, 2.0]);
let tines = [];
for y in [-12.0, 0.0, 12.0] { tines.push(cylinder([length + 4.99, y, 0], "X", 1.5, 25.0) + sphere([length + 30.0, y, 0], 1.6)); }
stick + head + fuse_all(tines)
