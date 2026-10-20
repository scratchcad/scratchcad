// Bobbin winder thread tension post: 22 x 10 x 2 mm base with 5 mm rounded ends and a 3.4 mm screw hole, 4 mm post 10 mm tall, 12 mm guide disc 1 mm thick on top, and a 1.2 mm thread eye through the post 3 mm above the base
let base_len = 22.0; // [16.0, 30.0] Base length (mm)
let post_h = 10.0; // [6.0, 16.0] Post height (mm)
let post_d = 4.0; // [3.0, 6.0] Post diameter (mm)
let disc_d = 12.0; // [8.0, 16.0] Disc diameter (mm)
const base_w = 10.0;
const base_t = 2.0;
let base = box_from_corners([-base_len / 2.0, -base_w / 2.0, 0], [base_len / 2.0, base_w / 2.0, base_t]);
let base = base.fillet(base_w / 2.0 - 0.2, base.edges("|Z"));
let px = base_len / 2.0 - base_w / 2.0;
let base = base - cylinder([-px, 0, -1.0], "Z", 1.7, base_t + 2.0);
let post = cylinder([px - 1.0, 0, base_t - 0.5], "Z", post_d / 2.0, post_h + 0.5);
let disc = cylinder([px - 1.0, 0, base_t + post_h - 0.2], "Z", disc_d / 2.0, 1.0);
fuse_all([base, post, disc]) - cylinder([px - 1.0, -post_d, base_t + 3.0], "Y", 0.6, 2.0 * post_d)
