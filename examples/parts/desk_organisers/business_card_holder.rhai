// Desk business card holder for 85 x 55 mm cards: 95 mm wide cradle holding a 25 mm stack leaning back 15 degrees, 2.5 mm walls, 30 mm front lip with a 40 mm thumb cut-out, solid 8 mm base
let card_w = 85.0; // [80.0, 92.0] Card width (mm)
let stack = 25.0; // [10.0, 40.0] Card stack depth (mm)
let lean = 15.0; // [0.0, 25.0] Lean back (degrees)
let lip = 30.0; // [15.0, 40.0] Front lip height (mm)
let back_h = 45.0; // [30.0, 60.0] Back wall height (mm)

const wall = 2.5;
const base_t = 8.0;
let w = card_w + 2.0 + 2.0 * wall;
let d = stack + 2.0 * wall;
let bh = max(back_h, lip + 5.0);
// the cradle is built upright: floor, front lip, back wall and sloped sides
let cradle = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, d, bh]) - box_from_corners([-w / 2.0 + wall, wall, wall], [w / 2.0 - wall, d - wall, bh + 10.0]);
cradle = cradle - box_from_corners([-w, -1.0, lip], [w, wall + 0.5, bh + 1.0]);
cradle = cradle - polygon([[-w, wall + 0.5, lip], [-w, d - wall, bh], [-w, wall + 0.5, bh + 1.0]]).to_face().extrude([2.0 * w, 0, 0]);
cradle = cradle - cylinder([0, -1.0, lip + 6.0], "Y", 20.0, wall + 2.0);
// tilt it back and fill underneath down to the base
let th = lean * PI() / 180.0;
let lift = d * sin(th);
let z0 = base_t - 1.0;
cradle = cradle.rotate_x(-lean).translate([0, 2.0, z0 + lift]);
let fill = polygon([[-w / 2.0, 2.0, 0], [-w / 2.0, 2.0 + d * cos(th), 0], [-w / 2.0, 2.0 + d * cos(th), z0 + 0.5], [-w / 2.0, 2.0, z0 + lift + 0.5]]).to_face().extrude([w, 0, 0]);
let base = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, 2.0 + d * cos(th) + bh * sin(th) + 2.0, base_t]);
base = base.fillet(4.0, base.edges("|Z"));
fuse_all([base, fill, cradle])
