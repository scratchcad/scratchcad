// Sliding stop for a 25 mm steel rule: 20 x 40 x 15 mm block, 25.5 x 1.2 mm slot through, 6 mm stop lip below, 12 mm boss with an M5 thumb-screw tap hole
let rule_w = 25.5; // [12.0, 32.0] Rule slot width (mm)
let rule_t = 1.2; // [0.6, 2.0] Rule slot height (mm)
let length = 20.0; // [12.0, 40.0] Block length along the rule (mm)
let lip = 6.0; // [3.0, 12.0] Stop lip depth (mm)
let w = rule_w + 14.0;
let blk = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, 15.0]);
let b = blk.fillet(2.0, blk.edges("|X and >Z"));
let stop = box_from_corners([0, -w / 2.0, -lip], [5.0, w / 2.0, 0.5]);
let boss = cylinder([length / 2.0, 0, 14.5], "Z", 6.0, 5.5);
b + stop + boss - box_from_corners([-1, -rule_w / 2.0, 4.0], [length + 1.0, rule_w / 2.0, 4.0 + rule_t]) - cylinder([length / 2.0, 0, 4.5], "Z", 2.1, 20.0)
