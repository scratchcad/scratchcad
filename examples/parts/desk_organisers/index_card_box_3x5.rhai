// Index card box for 3 x 5 in (76 x 127 mm) cards: 133 mm wide inside, 120 mm long for about 300 cards, walls 80% of the card height, 2.5 mm walls, 40 mm front finger dip, 4 mm side rails for tabbed dividers
let card_w = 127.0; // [100.0, 155.0] Card width (mm)
let card_h = 76.0; // [60.0, 105.0] Card height (mm)
let length = 120.0; // [60.0, 200.0] Box length front to back (mm)
let depth_ratio = 0.8; // [0.5, 0.95] Box depth as a share of the card height
let wall = 2.5; // [2.0, 4.0] Wall (mm)

const floor_t = 3.0;
let iw = card_w + 6.0;
let h = card_h * depth_ratio + floor_t;
let ow = iw + 2.0 * wall;
let ol = length + 2.0 * wall;
let box = box_from_corners([0, 0, 0], [ow, ol, h]);
box = box.fillet(5.0, box.edges("|Z"));
let inside = box_from_corners([wall, wall, floor_t], [ow - wall, ol - wall, h + 1.0]);
box = box - inside.fillet(2.5, inside.edges("|Z"));
// rails along both sides near the top carry tabbed dividers
let rails = [];
for x in [wall - 0.5, ow - wall - 3.5] {
    rails.push(box_from_corners([x, wall + 5.0, h - 12.0], [x + 4.0, ol - wall - 5.0, h - 8.0]));
}
box = box + fuse_all(rails);
box = box - cylinder([ow / 2.0, -1.0, h + 8.0], "Y", 20.0, wall + 2.0);
box.chamfer(0.6, box.edges("<Z"))
