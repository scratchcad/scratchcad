// Chain harrow tine link: rectangular link 100 x 50 mm outside forged from 12 mm square bar with 4 mm rounded outer corners, and a wedge tine 12 mm thick dropping 45 mm below one long side from a 30 mm root to a 4 mm tip
let link_len = 100.0; // [70.0, 140.0] Link length (mm)
let link_w = 50.0; // [36.0, 70.0] Link width (mm)
let bar = 12.0; // [8.0, 16.0] Bar section (mm)
let tine_len = 45.0; // [25.0, 70.0] Tine length (mm)
let tine_root = 30.0; // [18.0, 40.0] Tine root width (mm)
const tip = 4.0;
let outer = box_from_corners([-link_len / 2.0, -link_w / 2.0, 0], [link_len / 2.0, link_w / 2.0, bar]);
let outer = outer.fillet(4.0, outer.edges("|Z"));
let link = outer - box_from_corners([-link_len / 2.0 + bar, -link_w / 2.0 + bar, -1.0], [link_len / 2.0 - bar, link_w / 2.0 - bar, bar + 1.0]);
let tr = min(tine_root, link_len - 2.0 * bar - 6.0);
let y0 = -link_w / 2.0;
let tine = polygon([[-tr / 2.0, y0, bar / 2.0], [tr / 2.0, y0, bar / 2.0], [tip / 2.0, y0, -tine_len], [-tip / 2.0, y0, -tine_len]]).to_face().extrude([0, bar, 0]);
link + tine
