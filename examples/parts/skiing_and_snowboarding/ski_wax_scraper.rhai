// Ski wax scraper: 130 x 60 x 4 mm plate with one straight 90 degree scraping edge, six 4 mm V notches on the opposite edge for groove structure, and 6 mm corner radii on the grip side
let length = 130.0; // [100.0, 160.0] Scraper length (mm)
let t = 4.0; // [3.0, 6.0] Scraper thickness (mm)
const w = 60.0;
let s = box_from_corners([0, 0, 0], [length, w, t]);
let s = s.fillet(6.0, s.edges("|Z and >Y"));
let notches = [];
for i in 0..6 { notches.push(face(polygon([[length * 0.3 + i.to_float() * 8.0, -0.01, -1.0], [length * 0.3 + i.to_float() * 8.0 + 4.0, -0.01, -1.0], [length * 0.3 + i.to_float() * 8.0 + 2.0, 3.0, -1.0]])).extrude([0, 0, t + 2.0])); }
s - fuse_all(notches)
