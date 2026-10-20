// Label maker tape cartridge tray: 6 bays for 12 mm TZe-style cassettes (88 x 18 x 64 mm) standing on edge, 19 mm bays 89 mm long, 2 mm dividers, 30 mm deep so labels show, front finger scoops, stacking step 3 mm under the floor
let bays = 6; // [2, 10] Number of cassette bays
let bay_w = 19.0; // [13.0, 30.0] Bay width (mm)
let bay_l = 89.0; // [70.0, 110.0] Bay length (mm)
let depth = 30.0; // [20.0, 50.0] Tray depth (mm)
let divider = 2.0; // [1.5, 3.0] Divider thickness (mm)

const wall = 2.5;
const floor_t = 4.5;
const lip = 3.0;
let w = bays * bay_w + (bays - 1) * divider + 2.0 * wall;
let l = bay_l + 2.0 * wall;
let h = depth + floor_t;
let tray = box_from_corners([0, 0, 0], [w, l, h]);
tray = tray.fillet(4.0, tray.edges("|Z"));
let cuts = [];
for i in 0..bays {
    let x = wall + i * (bay_w + divider);
    cuts.push(box_from_corners([x, wall, floor_t], [x + bay_w, wall + bay_l, h + 1.0]));
}
tray = tray - compound(cuts);
// dividers stop below the rim, and the floor steps in underneath so trays stack
tray = tray - box_from_corners([wall, wall, h - lip - 0.5], [w - wall, l - wall, h + 1.0]);
let band = box_from_corners([-1.0, -1.0, -1.0], [w + 1.0, l + 1.0, lip]) - box_from_corners([wall + 0.3, wall + 0.3, -2.0], [w - wall - 0.3, l - wall - 0.3, lip + 1.0]);
tray = tray - band;
let scoops = [];
for i in 0..bays {
    let x = wall + i * (bay_w + divider) + bay_w / 2.0;
    scoops.push(cylinder([x, -1.0, h], "Y", min(bay_w / 2.0 - 1.0, depth * 0.4), wall + 2.0));
}
tray - compound(scoops)
