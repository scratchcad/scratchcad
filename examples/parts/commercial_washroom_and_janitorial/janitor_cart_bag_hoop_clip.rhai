// Janitor cart bag hoop clip: a 4 mm C clip 20 mm wide snapping onto a 25 mm frame tube (17 mm mouth), joined back to back by a 10 mm block to a smaller C clip that holds the 10 mm bag hoop rod (7 mm mouth)
let frame_d = 25.0; // [19.0, 32.0] Frame tube diameter (mm)
let hoop_d = 10.0; // [6.0, 14.0] Hoop rod diameter (mm)
let width = 20.0; // [12.0, 30.0] Clip width (mm)
let mouth = 0.7; // [0.6, 0.85] Mouth opening as a fraction of the diameter
const wall = 4.0;
let r1 = frame_d / 2.0 + 0.2;
let r2 = hoop_d / 2.0 + 0.2;
const gap = 10.0;
let x2 = r1 + wall + gap + r2 + wall;
let ring1 = cylinder([0, 0, 0], "Z", r1 + wall, width) - cylinder([0, 0, -1.0], "Z", r1, width + 2.0);
let ring1 = ring1 - box_from_corners([-r1 - wall - 1.0, -mouth * frame_d / 2.0, -1.0], [-r1 * 0.3, mouth * frame_d / 2.0, width + 1.0]);
let ring2 = cylinder([x2, 0, 0], "Z", r2 + wall, width) - cylinder([x2, 0, -1.0], "Z", r2, width + 2.0);
let ring2 = ring2 - box_from_corners([x2 + r2 * 0.3, -mouth * hoop_d / 2.0, -1.0], [x2 + r2 + wall + 1.0, mouth * hoop_d / 2.0, width + 1.0]);
let block = box_from_corners([r1 + wall - 1.5, -5.0, 0], [x2 - r2 - wall + 1.5, 5.0, width]);
let body = fuse_all([ring1, ring2, block]);
body - cylinder([0, 0, -1.0], "Z", r1, width + 2.0) - cylinder([x2, 0, -1.0], "Z", r2, width + 2.0)
