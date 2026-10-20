// Nurse bandage scissor holster: 26 x 12 mm pocket 75 mm deep with 1.5 mm walls and an open bottom for the blade tips, plus a 20 mm wide belt clip tongue 55 mm long with a 1.5 mm retaining bump
let pocket_w = 26.0; // [18.0, 34.0] Pocket width (mm)
let pocket_t = 12.0; // [8.0, 16.0] Pocket thickness (mm)
let depth = 75.0; // [55.0, 100.0] Pocket depth (mm)
const wall = 1.5;
let p = box_from_corners([-pocket_w / 2.0 - wall, 0, 0], [pocket_w / 2.0 + wall, pocket_t + 2.0 * wall, depth]);
p = p.fillet(3.0, p.edges("|Z"));
p = p - box_from_corners([-pocket_w / 2.0, wall, -1.0], [pocket_w / 2.0, pocket_t + wall, depth + 1.0]);
let clip = box_from_corners([-10.0, -wall - 1.5, depth - 55.0], [10.0, -1.5, depth]) + box_from_corners([-10.0, -1.51, depth - 6.0], [10.0, 0.01, depth]);
let bump = box_from_corners([-8.0, -wall - 3.0, depth - 50.0], [8.0, -wall - 1.49, depth - 46.0]);
p + clip + bump
