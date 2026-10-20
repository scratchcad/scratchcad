// SBS-footprint labware riser 30 mm for liquid-handler decks: 134.76 x 92.48 mm hollow block (SBS 127.76 x 85.48 plus a 3.5 mm rim), 2 mm walls and top, cross ribs underneath, 4 L-shaped corner posts 4 mm tall locating the plate with 0.5 mm clearance, 2 x 6 mm drain holes
let height = 30.0; // [10.0, 80.0] Riser height (mm)
let wall = 2.0; // [1.5, 4.0] Wall thickness (mm)
let post_h = 4.0; // [2.0, 8.0] Locating post height (mm)
const sbs_l = 127.76;
const sbs_w = 85.48;
const rim = 3.5;
const arm = 10.0;
let ol = sbs_l + 2.0 * rim;
let ow = sbs_w + 2.0 * rim;
let outline = box_centered(ol, ow, height + 2.0 * post_h).translate([0, 0, height / 2.0]).fillet(2.0, "|Z");
let riser = outline & box_centered(ol + 1.0, ow + 1.0, height).translate([0, 0, height / 2.0]);
riser = riser - box_centered(ol - 2.0 * wall, ow - 2.0 * wall, height).translate([0, 0, height / 2.0 - wall]);
let ribs = fuse_all([box_centered(ol - wall, wall, height - wall + 0.5).translate([0, 0, (height - wall + 0.5) / 2.0]), box_centered(wall, ow - wall, height - wall + 0.5).translate([0, 0, (height - wall + 0.5) / 2.0])]);
riser = riser + ribs;
// posts stand in the rim band, outside the plate outline plus 0.5 mm
let band = rim - 0.5;
let posts = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let x0 = sx * ol / 2.0;
        let y0 = sy * ow / 2.0;
        posts.push(box_from_corners([x0, y0, height - 0.5], [x0 - sx * arm, y0 - sy * band, height + post_h]));
        posts.push(box_from_corners([x0, y0, height - 0.5], [x0 - sx * band, y0 - sy * arm, height + post_h]));
    }
}
riser = riser + (fuse_all(posts) & outline);
riser - cylinder([-30.0, 20.0, height - wall - 1.0], "Z", 3.0, wall + 2.0) - cylinder([30.0, -20.0, height - wall - 1.0], "Z", 3.0, wall + 2.0)
