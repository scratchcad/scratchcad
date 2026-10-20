// Table tennis net post with screw clamp: 15 mm square post reaching 152.5 mm above the table, 15.25 cm overhang arm, C clamp for tables up to 30 mm thick, 40 x 40 mm jaws, M8 clamp screw boss
let net_height = 152.5; // [140.0, 160.0] Net height above the table (mm)
let post = 15.0; // [10.0, 20.0] Post size (mm)
let overhang = 152.5; // [0.0, 160.0] Post offset outside the table edge (mm)
let table_t = 30.0; // [15.0, 40.0] Maximum table thickness (mm)
let jaw = 40.0; // [30.0, 60.0] Jaw size (mm)
const plate_t = 6.0;
const spine_t = 8.0;
// the clamp's spine sits against the table edge at x = 0; the arm carries the post out to the overhang
let ox = max(overhang, spine_t + post / 2.0);
let top_jaw = box_from_corners([-jaw, -jaw / 2.0, 0], [ox + post / 2.0, jaw / 2.0, plate_t]);
let spine = box_from_corners([0, -jaw / 2.0, -table_t - 2.0 * plate_t], [spine_t, jaw / 2.0, plate_t]);
let low_jaw = box_from_corners([-jaw * 0.6, -jaw / 2.0, -table_t - 2.0 * plate_t], [spine_t, jaw / 2.0, -table_t - plate_t]);
let p = box_from_corners([ox - post / 2.0, -post / 2.0, plate_t - 0.5], [ox + post / 2.0, post / 2.0, net_height]);
let boss = cylinder([-jaw * 0.3, 0, -table_t - 2.0 * plate_t - 6.0], "Z", 8.0, plate_t + 6.0);
let np = fuse_all([top_jaw, spine, low_jaw, p, boss]);
np = np - cylinder([-jaw * 0.3, 0, -table_t - 2.0 * plate_t - 7.0], "Z", 3.4, plate_t + 15.0);
for z in [net_height - 10.0, net_height - 40.0, net_height - 70.0] {
    np = np - cylinder([ox, -post, z], "Y", 1.5, 2.0 * post);
}
np
